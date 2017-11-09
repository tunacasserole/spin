module BootgridHelper

  # This initializer generates the necessary JS script to activate
  # a JQuery Bootgrid. The purpose is to reduce the understanding of the
  # details and present a standard grid interface with limited options.
  # In the event this heper is too limiting, the developer may elect to
  # implement the script manually and provide all options needed.
  #
  # OPTIONS
  #
  # url
  #   The endpoint where the data will be provided
  #
  # formatters
  #
  def init_grid(name, options={})

    # Formatters
    formatters = options[:formatters] || {}
    formatted = ""
    formatters.each do |k,v|
      formatted << "'#{k}': " + v
      formatted << "," unless k = formatters.keys.last
    end

    # Extra URL parameter string
    extra = options[:extraParams] || {}
    extraParams = extra.to_json.to_s

    event_handlers = ""
    process_grid_handlers(name, event_handlers, options[:handlers] || {})

    script = <<-SCRIPT
    <script>
    $(function() {

        $("##{name}").bootgrid({
           ajax: true,
           url: '#{options[:url]}',
           requestHandler: function(request){
             var extraParams = JSON.parse('#{extraParams}');
             var out = Object.assign(request, extraParams)
             return out;
           },
           ajaxSettings: {
             method: "GET",
             cache: false
           },
           selection: false,
           columnSelection: true,
           rowCount: [10, 25, 100, -1],
           multiSelect: false,
           rowSelect: #{options[:selectable] || true},
           keepSelection: true,
           statusMappings: {},
           converters: {
             datetime: {
               from: function (value) { return moment(value); },
               to: gridToDateTime
             },
             yesno: {
               from: function(value){return value;},
               to: gridToYesNo
             },
             avatar: {
               from: function(value){return value;},
               to: gridToAvatar
             }
           },
           formatters: {
             #{formatted}
           },
           css: {
                        icon: 'zmdi icon',
                        iconColumns: 'zmdi-view-module',
                        iconDown: 'zmdi-sort-amount-desc',
                        iconRefresh: 'zmdi-refresh',
                        iconUp: 'zmdi-sort-amount-asc'
                    },
           templates: {
             headerCell: '<th data-column-id=\"{{ctx.column.id}}\" class=\"{{ctx.css}}\" style=\"{{ctx.style}}\"><a href=\"javascript:void(0);\" class=\"{{css.columnHeaderAnchor}} {{ctx.sortable}}\"><span class=\"{{css.columnHeaderText}}\">{{ctx.column.text}}</span></a></th>'
           }
        });


        $("##{name}").bootgrid()
        .on("loaded.rs.jquery.bootgrid", function (e)
            {
              registerGridToggle("##{name}");
        });

        #{event_handlers}

    });


    </script>
    SCRIPT
    script.html_safe
  end # def init_grid



  # Iterates over the handler configuration and generates the appropriate JS
  # scripts.
  def process_grid_handlers grid, script, config={}
    content = script || ""
    config.each do |event, options|
      case event.to_sym
      when :click
        content << process_click_handler(grid, options)
      end
    end
    content
  end # def process_grid_handlers


  def grid_attribute_toggle(field, options={})
    html = <<-HTML
    function(col, row) {
      var id="toggle-" + "#{field}" +  "-" + row["#{options[:primaryKey]}"];
      var checked = (row["#{field.to_s}"] === true ? "checked " : "");
      html = '<div class="toggle-switch"><input class="grid-toggle" id="' + id + '" type="checkbox" hidden="hidden" ' + checked
      html = html + 'data-toggle-field="#{field}" data-toggle-primaryKey="#{options[:primaryKey]}" '
      html = html + 'data-toggle-model="#{options[:model]}"'
      html = html + '><label for="' + id + '" class="ts-helper"></label></div>'
      return html;
    }
    HTML
    html.html_safe
  end # def build_it_grid_attribute_toggle

  def process_click_handler(grid, options={})

    "$('##{grid}').bootgrid()
        .on('click.rs.jquery.bootgrid', function (e,rows,record)
            {
              if (record !== undefined){
                location.href='#{options[:url]}/' + record.#{options[:identifier]} + '/edit';
              }
        });"
  end # process_click_handler

end # module BaseExplorerHelper
