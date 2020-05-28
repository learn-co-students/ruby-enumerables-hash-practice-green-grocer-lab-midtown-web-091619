#### My Code ####

def consolidate_cart(cart)
  output = {}
  cart.each do |item|
    item_name = item.keys[0]
    if output[item_name]
      output[item_name][:count] += 1 
    else
      output[item_name] = item[item_name]
      output[item_name][:count] = 1 
    end
  end
  output
end

####

def apply_coupons(cart, coupons)
  	  coupons.each do |coupon|
    if cart.keys.include? coupon[:item]
      if cart[coupon[:item]][:count] >= coupon[:num]
        new_name = "#{coupon[:item]} W/COUPON"
        if cart[new_name]
          cart[new_name][:count] += coupon[:num]
        else
          cart[new_name] = {  count: coupon[:num],  price: coupon[:cost]/coupon[:num],  clearance: cart[coupon[:item]][:clearance]  }
        end
        cart[coupon[:item]][:count] -= coupon[:num]
      end
    end
  end
  cart
end

####

def apply_clearance(cart)
   cart.keys.each do |item|
    if cart[item][:clearance]
      cart[item][:price] = (cart[item][:price]* 0.8).round(2)
    end
  end
  cart
end

####

def checkout(cart, coupons)
    cc = consolidate_cart(cart)
  cwca = apply_coupons(cc, coupons)
  cwda = apply_clearance(cwca)

  total = 0.0
  cwda.keys.each do |item|
    total += cwda[item][:price]*cwda[item][:count]
  end
  total > 100.00 ? (total * 0.90).round(2) : total
end