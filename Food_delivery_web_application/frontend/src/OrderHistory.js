import React, {useState, useEffect} from 'react'
import TopBar from './TopBar';

import { Link, Outlet } from 'react-router-dom'

export default function UserHistory(props){

    let auth = localStorage.getItem('auth');
    let loggedin = localStorage.getItem(auth+'_key')
    let user = JSON.parse(loggedin)[0];

    const [history, setHistory] = useState([]);

    //calls get orderhistory
    useEffect(() => {
      if (auth === 'user'){
      getOrderHistoryUser();
      }
      if(auth === 'restaurant'){
        getOrderHistoryRestaurant();}
    }, []);

    
    //gests users order history
    function getOrderHistoryUser() {
      fetch('http://localhost:3001/restaurantorderhistory', { 
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(user),
  })
    .then(response => {
      return response.text();
    })
    .then(data => {
      setHistory(JSON.parse(data))
    }) }

    //gets restaurants order history
    function getOrderHistoryRestaurant() {
      fetch('http://localhost:3001/userorderhistory', { 
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(user),
  })
    .then(response => {
      return response.text();
    })
    .then(data => {
      setHistory(JSON.parse(data))
    }) }
      

    if (auth !== null){
      
      if (auth === 'user'){

      return(
        <div>
        <div className="topBar">
          <TopBar/>
        </div>
          <Link to="/"><div style={{paddingRight:'50px'}}>Log Out</div></Link>
            <h3> YOUR ORDER HISTORY: </h3>
            <div className="orderHistory"> 
            { history.map(history =>
               <>
               <br/>
               <div> Restaurant: {history.restaurant_name} </div>
               <div> Order: {history.products.replaceAll(',',', ').slice(0, -2)} </div>
               <div> Total price: {history.total_price} </div>
               </>
            )}
            </div></div>)}

      if (auth === 'restaurant'){

        return (
          <div>
          <div className="topBar">
            <TopBar/>
          </div>
            <h3> YOUR ORDER HISTORY </h3>
            <div className="orderHistoryRestaurant"> 
            { history.map(history =>
               <>
               <br/>
               <div> Restaurant: {history.restaurant_name} </div>
               <div> Order: {history.products.replaceAll(',',', ').slice(0, -2)} </div>
               <div> Total price: {history.total_price} </div>
               </>
            )}
            </div></div>)}
    
    
    else{
    return(
      <div>
        <div>
          YOU HAVE TO LOG IN
        </div>
        <button><Link to="/"><div style={{paddingRight:'50px'}}> GO BACK AND LOGIN </div></Link></button>
        </div>
    )}
}}

