class Spin::Bootgrid

  def self.format_response(array, page, total)

    rows = []

    array.each do |x|
      puts x.inspect
      row = x.attributes
      if x.class.respond_to? 'marshalled_attributes'
        x.class.marshalled_attributes.each do |a|
          row.merge!(a.to_sym => x.send(a.to_sym))
        end
      end
      rows << row
    end

    response = { total: total, current: page, rows: rows }
    response.to_json
  end

end
