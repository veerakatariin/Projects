import { motion } from "framer-motion";
import { React } from "react";
import styles from './style.css';
import ReactDOM from 'react-dom';
import Header from "./Header";




const Image1 = () => {
    const style = {
        position: 'absolute',     
        left: '30px',             
        top: '50px',              
        backgroundImage:"url('https://iili.io/HWFnrwg.png')",
        width: '320px',
        height: '330px',
        zIndex: '1'               
    };
    return (
        <motion.h1
        animate={{ y: [50, 150, 50], opacity: 1, scale: 1 }}
        transition={{
            duration: 5,
            delay: 0.3,
            ease: [0.5, 0.5, 0.5, 0.5],
            repeat: Infinity
        }}
    >
         <div style={style}>
            </div>
    </motion.h1>
    );
};

const Image2 = () => {
  	const style = {
        position: 'absolute',   
        right: '20px',            
        top: '50px',             
        backgroundImage: "url('https://iili.io/HWFnQFp.png')",
        width: '320px',
        height: '330px',
        zIndex: '1'              
    };
    return (
        
         <motion.h1
      animate={{ y: [150, 50, 150], opacity: 1, scale: 1 }}
      transition={{
          duration: 5,
          delay: 0.3,
          ease: [0.5, 0.5, 0.5, 0.5],
          repeat: Infinity
      }}
  >
       <div style={style}>
          </div>
  </motion.h1>
    );
};


const Carousel = ()=>{
    const style = {
        position: 'absolute',   
        top: '200px',             
        width: '1900px',
        height: '300px',
        zIndex: '-1'              
    };


 return (
    <div style={style}>

<div class="slider">
	<div class="slide-track">
		<div class="slide">
			<img src="https://iili.io/HXgglbS.png" height="400" width="250" alt=""/> 
		</div> 	
		<div class="slide">
			<img src="https://iili.io/HXgglbS.png" height="400" width="250" alt=""/>
		</div>	
		<div class="slide">
			<img src="https://iili.io/HXgglbS.png" height="400" width="250" alt=""/>
		</div>	
		<div class="slide">
			<img src="https://iili.io/HXgglbS.png" height="400" width="250" alt="" />
		</div>	
		<div class="slide">
			<img src="https://iili.io/HXgglbS.png" height="400" width="250" alt="" />
		</div>	
		<div class="slide">
        <img src="https://iili.io/HXgglbS.png" height="400" width="250" alt=""/>
		</div>
		<div class="slide">
			<img src="https://iili.io/HXgglbS.png" height="400" width="250" alt="" />
		</div>
		<div class="slide">
			<img src="https://iili.io/HXgglbS.png" height="400" width="250" alt=""/>
		</div>
		<div class="slide">
			<img src="https://iili.io/HXgglbS.png" height="400" width="250" alt="" />
		</div>
		<div class="slide">
			<img src="https://iili.io/HXgglbS.png" height="400" width="250" alt=""/>
		</div>
		<div class="slide">
			<img src="https://iili.io/HXgglbS.png" height="400" width="250" alt="" />
		</div>
		<div class="slide">
			<img src="https://iili.io/HXgglbS.png" height="400" width="250" alt=""/>
		</div>
		<div class="slide">
			<img src="https://iili.io/HXgglbS.png" height="400" width="250" alt=""/>
		</div>
		<div class="slide">
			<img src="https://iili.io/HXgglbS.png" height="400" width="250" alt="" />
		</div>
	</div>
</div>
        
    </div>
 )

}

const App = () => {
    const style = {
      height: '120px'
  };
  return (
      <div style={style}>
       
        <Image1 />
        <Carousel />        
        <Image2 />          
      </div>
  );
};

const root = document.querySelector('#root');
ReactDOM.render(<App />, root);




export default App;


