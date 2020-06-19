import inspect

class Config(object):
    def get(self):
        line = inspect.stack()[1].code_context[0]
        names = map(str.strip, line.split('=')[0].split(','))
        args = [self.__dict__[name] for name in names]
        return args

if __name__ == "__main__":
    c = Config()
    c.option = 'Yes'
    c.value = 2.3
    c.φ = 23

    option, φ = c.get()

    print('option: ', option, ' φ: ', φ)
