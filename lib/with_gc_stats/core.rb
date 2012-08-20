class Object
  private
  def with_gc_stats(out=STDOUT,&block)
    if ruby_1_8?
      gc_ruby_1_8(out,&block)
    elsif ruby_1_9?
      gc_ruby_1_9(out,&block)
    end
  end

  def gc_ruby_1_8(out)
    raise "Ruby GC options not supported in Ruby 1.8 unless you install the patch at https://github.com/patshaughnessy/ruby187gc, or install Ruby EE" unless GC.respond_to? :enable_stats
    GC.enable_stats
    GC.clear_stats
    out.puts "How many GC Collections before running the code #{GC.collections}"
    out.puts "How many live objects we have before running the code #{ObjectSpace.live_objects}"
    allocated_before = ObjectSpace.allocated_objects
    yield
    out.puts "How many GC Collections after running the code #{GC.collections}"
    out.puts "How many live objects we have after running the code #{ObjectSpace.live_objects}"
    out.puts "Time spent in GC, in miliseconds #{GC.time / 1000}"
    out.puts "Total allocated objects by the code #{ObjectSpace.allocated_objects - allocated_before}"
    GC.disable_stats
  end

  def gc_ruby_1_9(out)
    GC::Profiler.enable
    yield
    out.puts GC::Profiler.report
    GC::Profiler.disable
  end

  def ruby_1_8?
    version = RUBY_VERSION.split('.')
    version[0]=='1' and version[1]=='8'
  end

  def ruby_1_9?
    version = RUBY_VERSION.split('.')
    version[0]=='1' and version[1]=='9'
  end
end