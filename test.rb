require 'em-tarantool'

EM.run do
  tar = EM::Tarantool.new('127.0.0.1', 33013)
  sp = tar.space(0, :int, :int, :str, :str, :int, indexes: [[0], [1,2]])
  sp.by_pk(0){|res|
    puts "Result: #{res.inspect}"
    sp.replace([1, 3, 'reqw', 'rewq', 'rewq'], return_tuple: true) {|af|
      puts "Affected #{af.inspect}"
      sp.all_by_keys(1, [[3, 'reqw'],[100]]){|res|
        puts "Results: #{res.inspect}"
        EM.stop
      }
    }
  }
end
