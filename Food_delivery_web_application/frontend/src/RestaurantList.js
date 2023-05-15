import React, {useState, useEffect} from 'react'
import { Link, Outlet } from 'react-router-dom'
import styles from './RestaurantList.module.css'
import OrderStatus from './OrderStatus.js';
import TopBar from './TopBar';
import RestaurantDetailView from './RestaurantDetailView.js'

// Listaa ravintolat sivulle

export default function RestaurantList() {
  let cart = localStorage.getItem('shoppincart')

  if(cart !== null){
    localStorage.removeItem('shoppincart')
    window.location.reload()
  }

  
  var user_key = localStorage.getItem('user_key')

  // props.restaurants = ravintolat tallennettuina. Esim. 'props.restaurants.name' = ravintolan nimi

  const [restaurant, setRestaurants] = useState([]);
  
// Hakee ravintolat tietokannasta. Ravintolat tallentuu 'restaurant' objektiin.
useEffect(() => {
  getRestaurant();
}, []);
function getRestaurant() {
  fetch('http://localhost:3001/customer_restaurants') // if developing locally: 'http://localhost:3001/r'. If to heroku: '/r'
  .then(response => {
    return response.text();
  })
  .then(data => {
    setRestaurants(JSON.parse(data));
    
  });
}

  if (user_key !== null){
  return (
    <div className={ styles.restaurantList }>
    <div className="topBar">
      <TopBar/>
    </div>
      <Link to="/"><div style={{paddingRight:'50px'}}>Log Out</div></Link>
    <OrderStatus/>
    
      <div>
      { restaurant.map(restaurant =>
        <Link to={ "/restaurants/"+restaurant.restaurant_id }>
          <div className={ styles.product }>
            <div><img className={ styles.image }src={`${restaurant.imagepath}`} /></div><div className={ styles.header }>{restaurant.name}</div><div>{restaurant.address}</div><div>{restaurant.price_level.replaceAll("o", "€")}</div></div>
        </Link>
      )}
      </div>
    </div>
  )}

  else {
    return(
      <div>
        <div>
          YOU HAVE TO LOG IN
        </div>
        <button><Link to="/"><div style={{paddingRight:'50px'}}>PALAA PÄÄSIVULLE</div></Link></button>
        </div>
      )
  }
}
