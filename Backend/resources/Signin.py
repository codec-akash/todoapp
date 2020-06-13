from flask_restful import Resource
from flask import request
from models import db, User
import random
import string

class signin(Resource):

    def post(self):
        json_data = request.get_json(force=True)
        if not json_data:
               return {'message': 'No input data provided'}, 400


## checking duplications ... 
        user = User.query.filter_by(username=json_data['username']).first()
        if not user:
            return {'message': 'Username does not exists'}, 400

        if user.password != json_data['password']:
            return {'message': 'Password Incorrect'}, 400

        result = User.serialize(user)

        return { "status": 'success', 'data': result }, 201

    def generate_key(self):
        return ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(50))
