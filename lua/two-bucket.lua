return {
    measure = function(args)
        local q = {}
        local st = {}
        table.insert(q, { 0, 0, 0 })
        while #q > 0 do
            local b1, b2, ct = table.unpack(table.remove(q, 1))
            if st[b1 .. "," .. b2] == 1 then
                goto continue
            end
            if args.start_bucket == 1 then
                if b1 == 0 and b2 == args.bucket_two_capacity then
                    goto continue
                end
            end
            if args.start_bucket == 2 then
                if b2 == 0 and b1 == args.bucket_one_capacity then
                    goto continue
                end
            end
            if b1 == args.goal_volume then
                return {
                    moves = ct,
                    other_bucket_volume = b2,
                    goal_bucket_number = 1,
                }
            end

            if b2 == args.goal_volume then
                return {
                    moves = ct,
                    other_bucket_volume = b1,
                    goal_bucket_number = 2,
                }
            end
            st[b1 .. "," .. b2] = 1
            local diff = math.min(b1, args.bucket_two_capacity - b2)
            table.insert(q, { b1 - diff, b2 + diff, ct + 1 })
            table.insert(q, { 0, b2, ct + 1 })
            table.insert(q, { args.bucket_one_capacity, b2, ct + 1 })
            diff = math.min(args.bucket_one_capacity - b1, b2)
            table.insert(q, { b1 + diff, b2 - diff, ct + 1 })
            table.insert(q, { b1, 0, ct + 1 })
            table.insert(q, { b1, args.bucket_two_capacity, ct + 1 })
            ::continue::
        end
        error("impossible")
    end,
}
