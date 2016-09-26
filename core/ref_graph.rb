class RefGraph
  attr_reader :ref_edges

  def initialize(edges)
    @ref_edges = edges.sort_by { |e| e.min_attrs }
  end
end


