import { Link } from 'react-router-dom';
import React, {useState, useEffect} from 'react'

export default function TopBar(){

    
  let [auth, setAuth] = useState();

    if (auth === 'user'){
        return(

        <div className="topBar" style={{backgroundColor:'lightblue'}}>
              <Link to="/restaurants"><div style={{paddingRight:'50px'}}>RESTAURANTS</div></Link>
              <Link to="/orderhistory"><div style={{paddingRight:'50px'}}>order history</div></Link>
            </div>
            
            )}
            
    else if (auth === 'restaurant'){
        
        return(

            <div className="topBar" style={{backgroundColor:'lightblue'}}>
                  <Link to="/restaurantui"><div style={{paddingRight:'50px'}}>YOUR RESTAURANTS</div></Link>
                  <Link to="/orderhistory"><div style={{paddingRight:'50px'}}>order history</div></Link>
                </div>
                
            )}
            
            else{
                setAuth(localStorage.getItem('auth'))
                return(

                    <div className="topBar">
                          Joo
                        </div>
                        
                    )
            }
    }