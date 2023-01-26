import flask

def sum(a,b):
    """Help to um two numbers

    Args:
        a (int): _description_
        b (int): _description_

    Returns:
        int: _description_
    """
    return a+b

def dot(a,b):
    return a*b

nombre = sum.__name__
documentacion = sum.__doc__

print(nombre, documentacion)