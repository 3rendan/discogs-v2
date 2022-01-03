if params[:stock].present?
  @stock = Stock.new_lookup(params[:stock])
  if @stock
    respond_to do |format|
      format.js { render partial: 'users/results'}
    end
  else
    respond_to do |format|
      flash.now[:alert] = "Please enter a valid symbol to search"
      format.js { render partial: 'users/results'}
    end
  end
else
  respond_to do |format|
    flash.now[:alert] = "Please enter a symbol to search"
    format.js { render partial: 'users/results'}
  end
end

_results
<strong>Symbol: </strong> <%= @stock.ticker %>
<strong>Name: </strong> <%= @stock.name %>
<strong>Price: </strong> <%= @stock.last_price %>
<% if current_user.can_track_stock?(@stock.ticker) %>
  <%= link_to 'Add to portfolio', user_stocks_path(user: current_user, ticker: @stock.ticker), class: 'btn btn-xs btn-success', method: :post %>
  <% else %>
    <span class="badge badge-secondary">
      You are already tracking
      <% if !current_user.under_stock_limit? %>
        10 Stocks
      <% end %>
      <% if current_user.stock_already_tracked?(@stock.ticker) %>
        this stock
      <% end %>

    </span>
  <% end %>
