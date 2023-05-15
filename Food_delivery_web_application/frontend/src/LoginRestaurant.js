import React, {useState, useEffect} from 'react'
import { Link, Navigate } from 'react-router-dom'
import RestaurantLoginForm from './components/RestaurantLoginForm';

export default function LoginConsumer() {

  var [login, setLogin] = useState(false);
  const [error, setError] = useState("");
  const [restaurant_key, setId] = useState([]);
  const [newRestaurantUser, setNewRestaurantUser] = useState({username: "", password: ""});

  var data_id = ''

  //checks login
  const Login = details => {
    fetch('http://localhost:3001/restaurant_login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(details)

    })
      .then(response => {
        return response.text();
      })
      .then(data => {
        setId(JSON.parse(data))
        if(data!=='[]'){
          
          setLogin(true)
        }
          else {
          }});      
        }

        if (Login){
          localStorage.setItem('restaurant_key', JSON.stringify(restaurant_key));
          localStorage.setItem('auth', 'restaurant');
        }

  //calls create login
  const submitHandler = (e) => {
    alert('a new user was submitted');
    createRestaurantLogin(newRestaurantUser);
    window.location.reload()
  }

  //creates a restaurant
  function createRestaurantLogin(newRestaurantUser) {

    fetch('http://localhost:3001/create_restaurant_login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(newRestaurantUser)
    })
      .then(response => {
        return response.text();
      })
      .then(data => {
      });
  }

  //handles logging out
  const Logout = () => {
    setLogin(false)
  }

  return (
    <div className="LoginRestaurant">
      {(login === true) ? (
        <div className="welcome">
          <Navigate to='/restaurantUi' />
          <button onClick={Logout}>Kirjaudu ulos</button>
        </div> ) : (
      <RestaurantLoginForm Login={Login} error={error}/>
     )}


 <div>
   <h2> Create an account </h2>
   <section>
               <label htmlFor="username"/> Enter your email <label/>
               <input type="text" name="username" id="username" onChange= { e => setNewRestaurantUser({...newRestaurantUser, username: e.target.value})} value={newRestaurantUser.username}></input>
               <br/><br/>

               <label htmlFor="password"/> Enter a password <label/>
               <input type="text" name="password" id="password" onChange= { e => setNewRestaurantUser({...newRestaurantUser, password: e.target.value})} value={newRestaurantUser.password}></input>
               <br/><br/>

        </section>

        <button onClick = {submitHandler}> create </button>
 </div>
    </div>
  );

  }
