import React, { useState, useEffect } from 'react'

import styles from './RestaurantDetailView.module.css'
import {  Link, useParams } from 'react-router-dom'
import RestaurantList from './RestaurantList';
import OrderStatus from './OrderStatus.js'
import TopBar from './TopBar';

let i = 0;
var SortedCart = {}
SortedCart.products = []
var cart_items = [];


export default function RestaurantDetailView(props, showContent) {


  // ravintolan menu tallentuu muuttujaarrayhyn 'menu'. Esim. 'menu.item_name' = tuotteen nimi
  const [menu, setMenu] = useState([]);
  const [all_restaurants, setRestaurants] = useState([])

  //const restaurantid = localStorage.getItem('restaurantdetailkey'+)

  var user_key = localStorage.getItem('user_key')
  let key = JSON.parse(user_key)


  useEffect(() => {
    getRestaurant();
    getMenuById();
  }, []);

  function getMenuById(){
const idarr = [{id: result.restaurant_id}]
    fetch('http://localhost:3001/restaurant_menu', { 
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(idarr),
  })
    .then(response => {
      return response.text();
    })
    .then(data => {
      setMenu(JSON.parse(data))
    });
  }
  

function getRestaurant() {
  fetch('http://localhost:3001/customer_restaurants') // if developing locally: 'http://localhost:3001/customer_restaurants'. If to heroku: '/customer_restaurants'
  .then(response => {
    return response.text();
  })
  .then(data => {
    setRestaurants(JSON.parse(data));
  });
}

// status joka määrittelee, näytetäänkö menu vai ostoskori. (myöhemmin shoppingcart omalle sivulle?)
    const [ViewStatus, setStatus] = useState('')
    

  // Händlää tuotteen lisäämisen listalle cart_items:
    const handleFoodClick = (menui) => {
      
      
      if(cart_items.includes(menui)){
          setStatus('menu_view');
      }
  
        else{
          cart_items[i] = SortedCart.products = menui
          i++
        setStatus('shoppingcart');
    
    };}

    const handleDeleteFromCart = (item) => {    // Status: näytetään ostoskori
      let a = 0
      cart_items.forEach(function(message){
   
        if (message === item){

              cart_items.splice(cart_items.indexOf(a),1)
              i = 0            
              setStatus('shoppingcart');             
            }
        else{
              a++}    
          }
        );
    }
      
  const result = useParams();
  const restaurant = all_restaurants.find(restaurant => restaurant.restaurant_id === parseInt(result.restaurant_id));
  if(restaurant == null) {
    return <div>No matching restaurant</div>
  }

  const RestaurantView = ({ViewStatus}) => {

      return(
        <div>
        <div className={styles.header}><h1>Add food to shoppincart</h1></div>
        <div className={styles.commonView}>
            <div className={styles.menuView}>{ menu.map(menu => <div> 
            <div className={styles.product}><button className={styles.button} onClick={() => handleFoodClick(menu)}>
               <img className={styles.image} 
            src={`${menu.imagepath}`}/> {menu.item_name}<div>{menu.description}</div><div>{menu.price} e</div></button></div></div>)}</div> </div>
            
            
          <div>Shopping cart</div>
        <div className={styles.menuInfo}>
        <CartView food={cart_items} />
        </div>
        
       
          
        </div>
      )
    }

  const CartView = ({food}) => {
    setStatus('menu_view');
    if(food < 1 ){
      
      return(
        <div>
          <p> Cart is empty </p>
        </div>
      )}
      else{


      var summa = 0
      cart_items.map(money => summa = summa+parseFloat(money.price))

    
      localStorage.setItem('shoppincart', JSON.stringify(cart_items)+'...'+restaurant.name+'...'+restaurant.owner_id);
    return(<div className={styles.shoppingcartContainer}>
        <div className={styles.shoppingcart}> {cart_items.map(prodes =>
        <div className={styles.shoppingcartContainer}><img className={styles.menuImage} 
        src={`${prodes.imagepath}`}/><div style={{}}> { prodes.item_name }<div>{ prodes.description }</div><div>{ prodes.price }</div></div> 
          <button style={{}} onClick={() => handleDeleteFromCart(prodes)}><div>DELETE</div></button></div>)}
          LOPPUSUMMA: {summa+"€"}<div>

            <Link to={"/payment/"}><button onClick = {ToPayment}  food = {cart_items} summa = {summa} style={{margin:'20px'}}>PAY</button></Link>
            
            
          </div>
          </div>
          </div>
           
    )}}
    
    const ToPayment = ({food, summa}) => {
      return(
        null
      )
    }

// Näyttää ravintolan tiedot sivulla: <button onClick={() => handleDeleteFromCart(prodes)}>delete</button>


  if (user_key !== null){

  return (
    <div>
    <div className="topBar">
      <TopBar/>
    </div>
      <Link to="/"><div style={{paddingRight:'50px'}}>Log Out</div></Link>
    <OrderStatus/><div className={styles.restaurantInfo}><img className={styles.restaurantImage} src={`${restaurant.imagepath}`} />
    <div>{restaurant.name} {restaurant.address}</div>
          <div>{restaurant.operating_hours} </div>{restaurant.restaurant_type} {restaurant.price_level.replaceAll("o", "€")}</div>
        <div>
          <RestaurantView ViewStatus={ViewStatus}/>
        </div>
        </div>
  )
}
else{
  return (
    <div>You must sign in</div>
  )

}
}