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
      { JSON.parse(k) => attrs_in(v)} 
    end
  end

end