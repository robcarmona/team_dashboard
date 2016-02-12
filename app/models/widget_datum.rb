class WidgetDatum < ActiveRecord::Base
  belongs_to :widget

  def get_data
    JSON.parse(data)
  end

end
