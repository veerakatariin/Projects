
import { useState, React, useEffect} from "react";
import { Link } from "react-router-dom";
import styles from './Style/LoginForm.css'
import Header from "./Main/Header";
import login from '../services/LoginService'
import profile from "../services/GetData.js"
import MainPage from "./MainPage";

const Login = (details) => {

    const [email, setEmail] = useState('')
    const [password, setPassword] = useState('')
    const [user, setUser] = useState(null)


    const handleSubmit = async (e) => {
        e.preventDefault()
        console.log("logging in with", email, password)

    try {
        const user = await login.login({
            email, password
        })
        window.localStorage.setItem(
            'loggedUser', JSON.stringify(user)
        )
        profile.setToken(user.token)
        setUser(user)
        setEmail('')
        setPassword('')
    } catch (exception) {
        console.log('wrong credentials')
    }
}


    return(
        <div className="background">
            <Header />
            <form onSubmit={handleSubmit} className="form">

                <h1 className="h1">Login </h1>

                <div className="inputfields">
                    <label for="username">Your email </label>
                    <input type="text" placeholder=" Enter valid email" name="email" value={email} onChange={({target}) => setEmail(target.value)} required />

                    <br></br>

                    <label for="password">Your password </label>
                    <input type="text" placeholder=" Enter password" name="password" value={password} onChange={({target}) => setPassword(target.value)} required />

                    <button className="button" onClick={() => handleSubmit()} >login </button>

                    <p className={styles.register}>
                        Not a member? 
                        <a href="/signup"> Register here</a>
                    </p>

                    <p className={styles.chandepwd} > 
                    <a href="changepswd">Forgot Password?
                    </a></p>

                </div>

            </form> 
            <Link to="/home"><button onClick={() => window.localStorage.clear()} >logout</button></Link>
        </div>
    )
}


export default Login;
