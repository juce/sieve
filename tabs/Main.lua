-- Eratosthenes Sieve

-- Use this function to perform your initial setup
function setup()
    print("Hello World!")
    
    sieve = Sieve()
    co = sieve:findPrimesSmallerThan(10000)
    
    parameter.watch('sieve.lastPrime')
    
    -- setup some animation to happen concurrently
    -- with the math
    e = {x = 10, y = 400}
    tween(5, e, {x=700}, 
        {easing = tween.easing.linear, loop = tween.loop.forever})
end

-- This function gets called once every frame
function draw()
    -- This sets a dark background color 
    background(40, 40, 50)

    -- This sets the line thickness
    strokeWidth(5)

    -- do some prime hunting
    if coroutine.status(co) ~= "dead" then
        ok, res = coroutine.resume(co)
        if not ok then
            print("PROBLEM:", res)
        elseif res then
            print("Found primes:", #res)
        end
    end
    
    -- some drawing
    ellipse(e.x, e.y, 60)
end

