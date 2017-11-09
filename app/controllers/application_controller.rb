class ApplicationController < ActionController::Base
  # require 'spin/search'
  # require 'spin/bootgrid'

  before_action :authenticate_admin!

  # generic helper responsibe for retrieving analytics
  # and formatting the response for charting.
  def process_analytics(model, format=:json, options={})
    [ User.signup_data, []]
  end # def process_search

  # generic helper responsibe for performing a full search including support
  # for sorting, paging and filtering.
  def process_search(model, format=:json, options={})
    page = params[:current] || 1
    limit = params[:rowCount] || 10

    query = build_query(model, options[:where])
    total = query.count

    # results =  limit == '-1' ? query : query.page(page).per(limit).all.to_a
    results =  limit == '-1' ? query : query.page(page).per(10).all.to_a
    Spin::Search.format_response(results, page.to_i, total )
  end # def process_search

  # The query will be dynamically established based on the parameters supplied
  # from the request. This will handle sorting, search, pagination and support
  # for tenancy.
  def build_query(model, where_clause)
    sort = params[:sort] || {}

    criteria = params[:searchPhrase]
    # query = (model.respond_to? :search) ? model.send(:search, criteria) : model

    query = Spin::Search.send(model.name.downcase.to_sym, criteria)

    query = query.where(where_clause) if where_clause

    sort.each do |k,v|
      query = query.order(k.to_sym => v)
    end

    query

  end # def build_query

  def set_current_admin
    Admin.current = current_admin
  end

end # class SpinController
