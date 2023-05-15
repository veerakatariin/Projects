import React from 'react';
import Header from './Main/Header';
import Carousel from './Main/Carousel';
import MainSection from './Main/MainSection';


const MainPage = () => {

    console.log("mainpage")
    return(
        <div>
            <Header />
           <Carousel />
          <MainSection />       
        </div>
        )
}

export default MainPage;

