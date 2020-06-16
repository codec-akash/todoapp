from flask_restful import Resource
from flask import request
from models import db, User, Task
import random
import string


class Tasks(Resource):

    def post(self):
        json_data = request.get_json(force=True)
        header = request.headers["Authorization"]

        if not header:
           return {
               "message": "No Api key"
           } , 400

        else:
            print(header)
            user = User.query.filter_by(api_key=header).first()
            if user:
                task = Task(
                    user_id = user.id,
                    note = json_data['note'],
                    completed = json_data['completed'],
                    repeats = json_data['repeats'],
                    deadline = json_data['deadline'],
                    reminders = json_data['reminders']
                )
                db.session.add(task)
                db.session.commit()

                result = Task.serialize(task)
                return { "status": 'success', 'data': result }, 201
            else :
               return {"message" : "No User"}, 400


    def get(self):
        result = []
        # json_data = request.get_json(force=True)
        header = request.headers["Authorization"]

        if not header:
           return {
               "message": "No Api key"
           } , 400

        else:
            print(header)
            user = User.query.filter_by(api_key=header).first()

            if user:
                tasks = Task.query.filter_by(user_id=user.id).all()
                for task in tasks:
                    result.append(Task.serialize(task))

            return { "status": 'success', 'data': result }, 201

        