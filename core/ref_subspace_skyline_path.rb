require_relative 'subspace_skyline_path'

require 'json'

class RefSubspaceSkylinePath < SubspaceSkylinePath
  attr_reader :ref_paths
 
  def initialize(params = {})
    super
  end

  def read_ref_paths
    file = File.read("ref-path-data/top_5.json")
    @ref_paths = JSON.parse(file).map do |k , v| 
      { JSON.parse(k) => attrs_in(v) } 
    end
  end

  def query_refgraph_skyline_path(params)
    query_skyline_path(params)
  end

  def next_hop?(n, pass, next_path_attrs)
    unless @distance_limit.nil?
      return false if out_of_limit?(next_path_attrs.first)
    end
    return false if pass.include?(n)
    return false if partial_dominance?(n, next_path_attrs)
    add_part_skyline(n, next_path_attrs)
    return false if reference_dominance?([pass.first, n], next_path_attrs)
    return false if full_dominance?(next_path_attrs)
    true
  end

  def reference_dominance?(target, path_attrs)
    unless @part_skyline_path[target].nil?
      result = @ref_paths[target].dominate?(path_attrs)
    end
    result ||= false
  end

end