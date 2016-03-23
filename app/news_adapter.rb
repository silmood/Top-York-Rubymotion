class NewsAdapter < Android::Widget::ArrayAdapter
  attr_writer :news

  class NewViewHolder
    attr_accessor :label_title
    attr_accessor :label_section
    attr_accessor :label_sub_section
    attr_accessor :label_by_line
  end

  def getView(position, convert_view, parent_view)
    if convert_view.nil?
      inflater = Android::View::LayoutInflater.from getContext
      convert_view = inflater.inflate(R::Layout::Item_top_new, parent_view, false)
      view_holder = NewViewHolder.new
      convert_view.setTag view_holder

      view_holder.label_title = convert_view.findViewById R::Id::Label_title
      view_holder.label_section = convert_view.findViewById R::Id::Label_section
      view_holder.label_sub_section= convert_view.findViewById R::Id::Label_sub_section
      view_holder.label_by_line= convert_view.findViewById R::Id::Label_by_line

    else
      view_holder = convert_view.getTag
    end

    new_item = getItem position
    view_holder.label_title.setText new_item["title"]
    view_holder.label_section.setText new_item["section"]
    view_holder.label_sub_section.setText new_item["subsection"]
    view_holder.label_by_line.setText new_item["byline"]

    convert_view

  end

end