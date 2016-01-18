def memoize(func):
    table = {}

    def wrapped(n):
        if n in table:
            return table[n]
        else:
            res = func(n)
            table[n] = res
            return res

    return wrapped

@memoize
def fib(n):
    if n == 0 or n == 1:
        return 1
    else:
        return fib(n-1) + fib(n-2)
