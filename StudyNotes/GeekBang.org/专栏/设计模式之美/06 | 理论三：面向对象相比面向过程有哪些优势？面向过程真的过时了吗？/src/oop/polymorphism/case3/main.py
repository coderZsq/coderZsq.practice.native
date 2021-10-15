class Logger:
    def record(self):
        print(“I write a log into file.”)

class DB:
    def record(self):
        print(“I insert data into db. ”)

def test(recorder):
    recorder.record()

def demo():
    logger = Logger()
    db = DB()
    test(logger)
    test(db)