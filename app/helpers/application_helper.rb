module ApplicationHelper
  
  def product_class(index)
    return (index%2==0) ? " mlx" : " mrx"
  end
  
end
