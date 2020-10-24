class XMLCreator
  def initialize(root:)
    @root = root
  end

  def call
    tag(label: @root)
  end

  private

  def tag(label:)
    "<#{label}>\n</#{label}>"
  end
end
