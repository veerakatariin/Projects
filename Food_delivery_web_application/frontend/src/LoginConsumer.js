import React, {useState, useEffect} from 'react'
import { Link, Navigate } from 'react-router-dom'
import LoginForm from './components/LoginForm';

export default function LoginConsumer() {

  var [login, setLogin] = useState(false);
  const error = useState("");
  const [user_key, setId] = useState([])
  const [newUser, setNewUser] = useState({username: "", password: ""});

//checks if login is ok
  const Login = details => {

    fetch('http://localhost:3001/user_login', {
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
          localStorage.setItem('user_key', JSON.stringify(user_key));
          localStorage.setItem('auth', 'user');
        }

//handles forms input variables
  const submitHandler = (e) => {
    alert('a new user was submitted');
    createUserLogin(newUser);
    window.location.reload()
  }

  //creates a new user account
  function createUserLogin(newUser) {

    fetch('http://localhost:3001/create_user_login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(newUser)
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
    <div className="LoginConsumer">
      {(login === true) ? (
        <div className="welcome">
          <Navigate to='/restaurants' />
          <button onClick={Logout}>Kirjaudu ulos</button>
        </div> ) : (
      <LoginForm Login={Login} error={error}/>
     )}


 <div>
   <h2> Create an account </h2>
   <section>
               <label htmlFor="username"/> Enter your email <label/>
               <input type="text" name="username" id="username" onChange= { e => setNewUser({...newUser, username: e.target.value})} value={newUser.username}></input>
               <br/><br/>

               <label htmlFor="password"/> Enter a password <label/>
               <input type="text" name="password" id="password" onChange= { e => setNewUser({...newUser, password: e.target.value})} value={newUser.password}></input>
               <br/><br/>

        </section>

        <button onClick = {submitHandler}> create </button>
 </div>
    </div>
  );

  }
