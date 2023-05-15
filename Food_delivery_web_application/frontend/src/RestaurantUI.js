import React, {useState, useEffect} from 'react'
import { Link, Outlet } from 'react-router-dom'
import styles from './RestaurantUi.module.css'
import TopBar from './TopBar';
import CreateMenu from './CreateMenu'

export default function RestaurantUI(){


var restaurant_key = localStorage.getItem('restaurant_key')

let [state, setState] = useState('rest')

let rest_id


  // props.restaurants = ravintolat tallennettuina. Esim. 'props.restaurants.name' = ravintolan nimi

  const [restaurant, setRestaurants] = useState([]);
  let checkStatus
  
// Hakee ravintolat tietokannasta. Ravintolat tallentuu 'restaurant' objektiin.

//muokkaus: only restaurants where id =?

const restaurants_by_id = [{id: JSON.parse(restaurant_key)[0].restaurant_id}]

useEffect(() => {
  getRestaurantsById();
}, []);
function getRestaurantsById(){
    fetch('http://localhost:3001/myrestaurants', { 
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(restaurants_by_id),
  })
    .then(response => {
      return response.text();
    })
    .then(data => {
      setRestaurants(JSON.parse(data))
    });
  }

  function handleEditMenu(id){
    rest_id = id
    setState('menu')
  }


  let status = localStorage.getItem('status')
  let check_status = [] 

  if (status !== null){
  // [0]: statusinfo, [1]: orderer_id, [2]: restaurant_id
    check_status = status.split('...')

    if (restaurants_by_id[0].id===parseInt(check_status[2])){
      checkStatus = true
    }
    else {
      checkStatus = false
    }
  }

  
    function setStatus(){
        if (check_status[0] === 'received'){
          localStorage.setItem('status', 'preparing'+'...'+check_status[1]+'...'+check_status[2])
          window.location.reload()
        }
        else if (check_status[0] === 'preparing'){
          localStorage.setItem('status', 'delivering'+'...'+check_status[1]+'...'+check_status[2])
          window.location.reload()
        }
        else {
          localStorage.setItem('status', 'delivered'+'...'+check_status[1]+'...'+check_status[2])
          window.location.reload()
        }
    }
  

  if (restaurant_key !== null){

    if (state !== 'menu'){

  // check_status[0]: statusinfo, [1]: orderer_id, [2]: restaurant_id
  return (
    <div className={ styles.restaurantList }>
    <div className="topBar">
      <TopBar/>
    </div>
      <Link to="/"><div style={{paddingRight:'50px'}}>Log Out</div></Link>
      <div>{(checkStatus) ? (<div style={{fontSize:'40px'}}>You have an open order with status:{check_status[0]}<div>from {check_status[1]}</div><div><button onClick={setStatus}>CHANGE STATUS</button></div></div>) : (<div></div>)}
          
      { restaurant.map(restaurant =>
          <div className={ styles.product }>
            <div><img className={ styles.image }src={`${restaurant.imagepath}`} /></div>
            <div className={ styles.header }>{restaurant.name}</div>
            <div>{restaurant.address}</div><div><Link to={ "createmenu/"+restaurant.restaurant_id }>
               <button className={styles.button}onClick={() => handleEditMenu(restaurant.restaurant_id)}>EDIT MENU</button></Link></div></div>
      )}
      </div>
      <Link to="createrestaurant"><button> Create new Restaurant </button></Link>
    </div>
  )}
else {
  return(
  <CreateMenu rest_id = {rest_id}/>
  )
}
}

  else {
    return(
    <div className="restaurantInfo">
        INFO
      </div>
      )
  }
}