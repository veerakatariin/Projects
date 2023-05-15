
import { Link } from 'react-router-dom'
import React from 'react'


export default function Home() {

  //manages local storage
  var status_save = localStorage.getItem('status')
  localStorage.clear();
  localStorage.setItem('status', status_save)

  return (
    <div>
      <h1>LOGIN</h1>
      <h3>LOGIN OR SIGN UP</h3>

      <Link to="loginconsumer"><button>CUSTOMER</button></Link>
      <Link to="loginrestaurant"><button>RESTAURANT</button></Link>
      <br/><br/>

    </div>
  
  )
}
