import './App.css';
import Home from './Home';
import LoginRestaurant from './LoginRestaurant'
import LoginConsumer from './LoginConsumer';
import RestaurantList from './RestaurantList'
import RestaurantDetailView from './RestaurantDetailView'
import RestaurantUI from './RestaurantUI';
import CreateRestaurant from './CreateRestaurant';
import OrderHistory from './OrderHistory';
import PaymentView from './PaymentView';

import { BrowserRouter, Routes, Route } from 'react-router-dom';
import React from 'react'
import CreateMenu from './CreateMenu';


function App() {


  //Connections to other components
  return (
    <BrowserRouter>
        <Routes>
          <Route path="/" element={ <Home /> } />
          <Route path="/loginrestaurant" element={ <LoginRestaurant /> } />
          <Route path="/loginconsumer" element={ <LoginConsumer /> } />
          <Route path="/restaurants" element={ <RestaurantList /> } />
          <Route path="/restaurants/:restaurant_id/*" element={ <RestaurantDetailView restaurant={RestaurantDetailView}/> } />
          <Route path="restaurantui/createmenu/:id/*" element={ <CreateMenu rest_id={CreateMenu}/> } />
          <Route path="/restaurantui" element = { <RestaurantUI /> } />
          <Route path="/restaurantui/createrestaurant" element = { <CreateRestaurant /> } />
          <Route path="/orderhistory" element = { <OrderHistory /> } />
          <Route path="/payment" element = { <PaymentView /> } />

        </Routes>

        <br/><br/><br/><br/><br/><br/>
        
        
    </BrowserRouter>
  );
}


export default App;

