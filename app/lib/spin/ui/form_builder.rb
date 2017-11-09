class Spin::Ui::FormBuilder < ActionView::Helpers::FormBuilder

  def input_group_wrapper(arg)
    @template.content_tag(:div, class: 'input-group') do
      "<span class='input-group-addon'>#{arg}</span>".html_safe +
      yield
    end
  end # def input_group_wrapper

  def field_wrapper(attribute, args)
    id = args[:id] || "field-#{attribute}"
    label = args[:label] || attribute.to_s.titleize

      @template.content_tag(:div, class: 'form-group', id: id) do
          if args[:no_label]
            yield +
            "<i class='form-group__bar'></i>".html_safe
          else
            @template.content_tag(:label, label) +
            yield +
            "<i class='form-group__bar'></i>".html_safe
          end
      end

  end

  def text_field(attribute, args = {})
    args[:class] = 'form-control form-control-lg'
    if args[:input_group]
      input_group_wrapper(args[:input_group]) do
        field_wrapper(attribute, args) do
          super(attribute, args)
        end
      end
    else
      field_wrapper(attribute, args) do
        super(attribute, args)
      end
    end
  end # def text_field

  def text_area(attribute, args = {})
    args[:class] = 'form-control form-control-lg textarea-autosize'
    field_wrapper(attribute, args) do
      super(attribute, args)
    end
  end # def text_area

  def phone_field(attribute, args = {})
    text_field(attribute, args)
  end

  def email_field(attribute, args = {})
    text_field(attribute, args)
  end

  def locator_field(method, model, display_attribute, select_options = {}, input_options = {}, &block)

    choices = model.where(model.primary_key => @object.send(method.to_sym)).map {|rec| [rec.send(display_attribute.to_sym), rec.send(model.primary_key)]}
    select(method, choices, select_options, input_options)
  end # def locator_field

  def lookup_field(attribute, category, args={})
    choices = BuildIt::Util::Lookup::Manager.lookup category
    args[:hide_search] = true
    select(attribute, choices, args)
  end # def lookup_field

  # Advanced helper to wrap a text field providing an input mask on entry.
  def masked_field(attribute, args = {})
    text_field(attribute, args)
  end # def masked_field


  # def select(method, choices = nil, select_options = {}, input_options = {}, &block)
  #   id = input_options[:id] || "field-#{method}"
  #   label_text = input_options[:label] || method.to_s.humanize
  #   label_options = options.fetch(:label_options, {})
  #   input_defaults = { class: 'select2 form-control-lg' }

  #   input_defaults["data-minimum-results-for-search"] = "Infinity" if select_options[:hide_search] == true
  #   input_options = merge_options(input_defaults, options.fetch(:input_options, {}))

  #   @template.content_tag(:div, class: 'form-group', id: id) do

  #         if input_options[:no_label]
  #             super(method, choices, select_options, input_options, &block)
  #         else
  #           @template.content_tag(:label, label_text) +
  #               super(method, choices, select_options, input_options, &block)
  #         end

  #   end
  # end

  def date_field(attribute, args = {})
    args[:class] = 'input-lg form-control date-picker'
    field_wrapper(attribute, args) do
      ActionView::Helpers::Tags::TextField.new(@object_name, attribute, self, args).render
    end
  end

  private

  def merge_options(defaults, new_options)
    (defaults.keys + new_options.keys).inject({}) do |h, key|
      h[key] = [defaults[key], new_options[key]].compact.join(' ')
      h
    end
  end
end
