//import React from "react";
import styles from'./Header.module.css';
import { Link } from "react-router-dom";
import React, {useState, useEffect, useRef} from 'react';



function Header() {
  
const [open, setOpen] = useState(false);

  let menuRef = useRef();

  useEffect(() => {
    let handler = (e)=>{
      if(!menuRef.current.contains(e.target)){
        setOpen(false);
        console.log(menuRef.current);
      }      
    };

    document.addEventListener("mousedown", handler);
    
    return() =>{
      document.removeEventListener("mousedown", handler);
    }

  });


  const loggedUserJSON = window.localStorage.getItem('loggedUser')
  
  if (loggedUserJSON === null){
   console.log("on") //ei ole kirjautunut
   

    return  (

        
        <div className={ styles.headerBackground }>
            <div className={ styles.container }>
                 <Link to="/home"><div className={ styles.logo }><div><img src="https://iili.io/HamlA67.png"
                    height={80}
                    width={300}/></div></div></Link>

            <div className={ styles.container }>
                <Link to="/home"><div className={styles.brand}> Front page </div></Link>
                <Link to="/browse"><div className={styles.brand}> Browse </div></Link>
                <Link to="/aboutus"><div className={styles.brand}> About us </div></Link> 
                </div> 
                <div className="App">
                <div className='menu-container' ref={menuRef}>
                <div className='menu-trigger' onMouseEnter={()=>{setOpen(!open)}}>
                <img src= "https://iili.io/HamP0Ou.png"
                height={55}
                width={55}></img>
                </div>
                <div className={`dropdown-menu ${open? 'active' : 'inactive'}`} >
        
                <Link to="/login"><DropdownItem text = {"Log in"}/></Link>
                <Link to="/signup"><DropdownItem text = {"Sign in"}/></Link>
                </div>

                </div>
</div>
            </div>
        </div>
    )}


    else{
      console.log("ei") //on kirjautunut
    return  (

        
      <div className={ styles.headerBackground }>
          <div className={ styles.container }>
               <Link to="/home"><div className={ styles.logo }><div><img src="https://iili.io/HamlA67.png"
                  height={80}
                  width={300}/></div></div></Link>

          <div className={ styles.container }>
              <Link to="/home"><div className={styles.brand}> Front page </div></Link>
              <Link to="/browse"><div className={styles.brand}> Browse </div></Link>
              <Link to="/aboutus"><div className={styles.brand}> About us </div></Link> 
              </div> 
             
              <div className="App">
              <div className='menu-container' ref={menuRef}>
              <div className='menu-trigger' onMouseEnter={()=>{setOpen(!open)}}>
              <img src= "https://iili.io/HamP0Ou.png"
              height={55}
              width={55}></img>
              </div>
              <div className={`dropdown-menu ${open? 'active' : 'inactive'}`} >
      
              <Link to="/profile"><DropdownItem text = {"Profile"}/></Link>
              <Link to="/review"><DropdownItem text = {"Reviews"}/></Link>
              <Link to="/task"><DropdownItem text = {"Tasks"}/></Link>
              <Link to="/home"><text onClick={() => window.localStorage.clear()} >Log out</text></Link>


              </div>

              </div>
</div>
          </div>
      </div>
  )}
}


function DropdownItem(props){
    return(
      <li className = 'dropdownItem'>
        <img src={props.img}></img>
        <a> {props.text} </a>
      </li>

      
    );
  }
  
export default Header; 