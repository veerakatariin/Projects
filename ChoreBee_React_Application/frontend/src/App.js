import { useEffect, React } from "react";
import { BrowserRouter, Routes, Route, Link } from "react-router-dom";

import MainPage from "./components/MainPage";
import ProfilePage from "./components/ProfilePage";
import Login from "./components/Login";
import SignUp from "./components/SignUp";
import ChangePassword from "./components/ChangePassword";
import GetData from "./services/GetData";
import EditProfile from "./components/EditProfile";
import Task from "./components/Task";
import Reviews from  "./components/Review";
import NewTaskForm from "./components/newTaskForm";
import EditTask from "./components/EditTask";
import Browse from "./components/Browse";
import AboutUs from "./components/AboutUs";
import NewReviewForm from "./components/newReviewForm";
import ApplyForTask from "./components/ApplyForTask";

function App() {

  useEffect(() => {
    GetData
    .getUsers()
    .then(res => {
    })
  }, [])

  return (
    <div>
  <BrowserRouter>
      <Routes>
      <Route path="/home" element={<MainPage/>}/>
      <Route path="/profile" element={<ProfilePage/>}/>
      <Route path="/editprofile" element={<EditProfile/>}/>
      <Route path="/task" element={<Task/>}/>
      <Route path="/newtask" element={<NewTaskForm/>}/>
      <Route path="/edittask" element={<EditTask/>}/>
      <Route path="/review" element={<Reviews/>}/>
      <Route path="/browse" element={<Browse/>}/>
      <Route path="/aboutus" element={<AboutUs/>}/>
      <Route path="/newreview" element={<NewReviewForm/>}/>
      <Route path="/applyfortask" element={<ApplyForTask/>}/>
    
      <Route path="/login" element={<Login/>}/>
      <Route path="/signup" element={<SignUp/>}/>
      <Route path="changepswd" element={<ChangePassword/>}/>
      </Routes>

      <Link to="/newreview"><button>new review</button></Link>
      <Link to="/changepswd"></Link>
     
  </BrowserRouter>
    </div>
  );
}

export default App;

/*
      <Link to="/profile"><button>profile</button></Link>
      <Link to="/editprofile"><button>edit profile</button></Link>
      <Link to="/task"><button>task</button></Link>
      <Link to="/newtask"><button> create a task</button></Link>
      <Link to="/review"><button>review</button></Link>
      <Link to="/browse"><button>browse</button></Link>

      <Link to="/login"><button>loginpage</button></Link>
      <Link to="/signup"><button>signup</button></Link>
      <Link to="/changepswd"></Link>

      */