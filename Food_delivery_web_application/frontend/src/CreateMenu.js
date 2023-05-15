import { Link, useParams } from 'react-router-dom'
import React, {useState, useEffect} from 'react'
import TopBar from './TopBar';
import styles from './CreateMenu.module.css'

export default function CreateMenu(){

    const [details, setDetails] = useState({item_name:"", description:"", price:"", imagepath:"", owner_id:""});
    const [menu, setMenu] = useState([]);
    const submitHandler = (e) => {
        alert('menu was submitted');
        setDetails(details.owner_id = rest_id )
        //setDetails(details.owner_id = 1);
        createMenu(details);
    }

    //gets restaurants menu by id 
      function getMenuById(){
      fetch('http://localhost:3001/restaurant_menu', { 
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify([{id: rest_id}]),
    })
      .then(response => {
        return response.text();
      })
      .then(data => {
        setMenu(JSON.parse(data))
      });
    }

    //creates new menu for a restaurant
    function createMenu(details){

        fetch('http://localhost:3001/create_restaurant_menu', { 
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(details),
      })
        .then(response => {
          return response.text();
        })
        .then(data => {
        });
      }

      //checks menus id and calls the getmenu function
      const result = useParams();
      const rest_id = result.id
      useEffect(() => {
        getMenuById();
      }, []);
      if(rest_id === null) {
        return <div>Something went wrong</div>
      }

      var restaurant_key = localStorage.getItem('restaurant_key')
      if (restaurant_key !== null){

        //form for creating a menu
        //requires authentication if not logged in
    return (
        <div>
        <div className="topBar">
          <TopBar/>
          
        </div>
        <div>
        <div className={ styles.menu }>{ menu.map(menu =>
            <div>  <div>{menu.item_name}</div>
               <img className={ styles.image }
            src={`${menu.imagepath}`}/></div>)}</div></div>
        <h1> Create a menu for your restaurant </h1>
        <br />

        
        <section>
            <form onSubmit = {submitHandler}>
               <label for="item_name"/> Enter a name <label/>
               <input type="text" name="item_name" id="item_name" onChange= { e => setDetails({...details, item_name: e.target.value})} value={details.item_name}></input>
               <br/><br/>

               <label for="description"/> Enter a description <label/>
               <input type="text" name="description" id="description" onChange= { e => setDetails({...details, description: e.target.value})} value={details.description}></input>
               <br/><br/>

               <label for="price"/> Enter a price <label/>
               <input type="text" name="price" id="price" onChange= { e => setDetails({...details, price: e.target.value})} value={details.price}></input>
               <br/><br/>

               <label for="imagepath"/> Enter an imagepath for your image <label/>
               <input type="text" name="imagepath" id="imagepath" onChange= { e => setDetails({...details, imagepath: e.target.value})} value={details.imagepath}></input>
               <a href="https://fi.imgbb.com/" target="_blank" rel="noopener noreferrer">CLICK HERE TO UPLOAD NEW IMAGE</a>
                <div>(if you don't have one yet, You can upload one throught the link and copy the url as show in the image below: )</div><br/>
                <div><img className={ styles.menuimage }src={`/images/example.png`} /></div><br/>

               </form>

        </section>

        <Link to="/restaurantui"><button onClick = {submitHandler}> Submit </button></Link>
        </div>
    )
  }

  else{
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

