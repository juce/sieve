Sieve = class()

function Sieve:findPrimesSmallerThan(n)
    -- op-counter: to slice the work into small chunks
    local op, MAXOP = 0, 200
    return coroutine.create(function()
        print("Looking for primes <", n, "...")
        self.results = {}
        local t = {}
        for i=2,n do 
            t[i] = i 
        end
        local p = 2
        while p < n do
            if t[p] then
                self.lastPrime = p
                local x = p * p
                while x < n do
                    t[x] = nil
                    x = x + p
                    -- only do a slice of work
                    op = op + 1
                    if op % MAXOP == 0 then
                        coroutine.yield()
                    end
                end
                self.results[#self.results + 1] = p
            end
            p = p + 1
            -- only do a slice of work
            op = op + 1
            if op % MAXOP == 0 then
                coroutine.yield()
            end
        end
        print("Prime hunting done.")
        return self.results
    end)
end
