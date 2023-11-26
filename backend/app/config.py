import os
from dotenv import load_dotenv


class Config(object):
    def __init__(self):
        load_dotenv()

        self.ACCESS_TOKEN_EXPIRE_MINUTES = int(os.getenv("ACCESS_TOKEN_EXPIRE_MINUTES"))
        self.ALGORITHM = os.getenv("ALGORITHM")
        self.SECRET_KEY = os.getenv("SECRET_KEY")
        self.DATABASE_TYPE = os.getenv("DATABASE_TYPE")
        self.DATABASE_HOST = os.getenv("DATABASE_HOST")
        self.DATABASE_PORT = os.getenv("DATABASE_PORT")
        self.DATABASE_USERNAME = os.getenv("DATABASE_USERNAME")
        self.DATABASE_PASSWORD = os.getenv("DATABASE_PASSWORD")
        self.DATABASE_NAME = os.getenv("DATABASE_NAME")

    def __new__(cls):
        if not hasattr(cls, 'instance'):
            cls.instance = super(Config, cls).__new__(cls)
        return cls.instance