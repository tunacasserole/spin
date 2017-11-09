class Spin::Util::Data::SeedProxy < $SeedProxyStruct ||= Struct.new(:name, :version, :filename)

  def initialize(name, version, filename)
    super
    @migration = nil
  end
end
