import Header from "./Main/Header";
import { useEffect, React, useState } from "react";
import profile from "../services/GetData.js"
import { Link } from "react-router-dom";


const EditProfile = () => {

    const [user, setUser] = useState({})
    const [newName, setName] = useState()
    const [des, setDes] = useState()
    const [number, setNumber] = useState()
    const [email, setEmail] = useState()
    const [age, setAge] = useState()
    const [address, setAddress] = useState()
    const [password, setPassword] = useState()

    const loggedUserJSON = window.localStorage.getItem('loggedUser')
    const userlog = JSON.parse(loggedUserJSON)
    
    const userObject = {
        name: newName,
        age: age, 
        info: des,
        number: number,
        address: address,
        email: email,
        password: password
      }

        useEffect(() => {
          profile
          .getUser(userlog.id)
          .then(res => {
            setUser(res);
            setName(res.name)
          })
        }, [])
      

      const handleNameChange = (event) => {
        setName(event.target.value)
        console.log(newName)
      }
      const handleDesChange = (event) => {
        setDes(event.target.value)
        console.log(des)
      }
      const handleEmailChange = (event) => {
        setEmail(event.target.value)
      }
      const handleAgeChange = (event) => {
        setAge(event.target.value)
      }
      const handleAddressChange = (event) => {
        setAddress(event.target.value)
      }
      const handleNumberChange = (event) => {
        setNumber(event.target.value)
      }
      const handlePasswordChange = (event) => {
        setPassword(event.target.value)
      }

      const update = () => {
        profile.updateUser(userlog.id, userObject)
        //console.log('päivitetään käyttäjä' + userObject)
      }
      
    return(
      
    <div>
      <Header />
      <form input type="submit">
            <ul>
                <li>
                    <label for="name">Full name:</label>
                    <input type="text" id="name" name="name" defaultValue={user.name} onChange={handleNameChange}/>
                </li>
                <li>
                    <label for="description">Description:</label>
                    <input type="text" id="des" name="description" defaultValue={user.info} onChange={handleDesChange}/>
                </li>
                <li>
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" defaultValue={user.email} onChange={handleEmailChange}/>
                </li>
                <li>
                    <label for="phone">Phone:</label>
                    <input type="text" id="number" name="number" defaultValue={user.number} onChange={handleNumberChange} />
                </li>
                <li>
                    <label for="age">Age:</label>
                    <input type="text" id="age" name="age" defaultValue={user.age} onChange={handleAgeChange} />
                </li>
                <li>
                    <label for="address">Address:</label>
                    <input type="text" id="address" name="address" defaultValue={user.address} onChange={handleAddressChange}/>
                </li>
                <li>
                    <label for="password">Password:</label>
                    <input type="text" id="pwd" name="pwd" defaultValue={user.password} onChange={handlePasswordChange}/>
                </li>
            </ul>
            <Link to="/profile"><button type="button" className="button" onClick={update}>Update</button></Link>
        </form>
    </div>
    
)}

export default EditProfile
