import React, {useEffect, useRef, useState} from 'react';
import Arrow from '../assets/Arrow.jsx'
import {Link, useNavigate} from "react-router-dom";
import {useDispatch, useSelector} from "react-redux";

const IndexPage = () => {
    const [phone, setPhone] = useState("")
    const BACKEND_URL = import.meta.env.VITE_BACKEND_URL
    const navigate = useNavigate();
    const dispatch = useDispatch()
    const Auth = () => {
        if(phone.length === 12){
            fetch(BACKEND_URL + `/doctor/?phone=${phone.replace("+", "%2B")}`)
                .then(response => response.json())
                .then(data => {
                    if(data.name !== undefined){
                        dispatch({type: "CHANGE_VALUE_DOCTORID", payload: data.id})
                        navigate("/search")
                    }
                })
        }
    }
    return (
        <div className="max-w-screen w-screen h-screen">
            <div className="w-full h-full pt-[40px] pb-[441px] bg-sky-100 flex-col justify-start items-center gap-[188px] inline-flex">
                <div className="self-stretch flex-col justify-center items-center inline-flex">
                    <div className="text-center text-[#6B9CD6] text-[84.46px] font-bold text_Jost">NeoCancer</div>
                    <div className="text-center text-[#6B9CD6] text-[40px] font-normal text_Jost">для врачей</div>
                </div>
                    <div className="self-stretch flex-col justify-center items-center gap-5 inline-flex">
                        <div className="text-center text-[#6B9CD6] text-[28.88px] font-normal text_Jost">Телефон</div>
                        <div className="justify-start items-end gap-[18px] inline-flex">
                            <div className="w-[417px] h-[74px] bg-white rounded-[18.05px] drop-shadow-xl justify-between items-center flex">
                                <input onChange={(e) => setPhone(e.target.value)} type="tel" id="phone" name="phone" className="bg-white h-full w-full px-8 py-4 text_Jost text-black text-[24px] rounded-[18.05px]" placeholder="+79999999999"/>
                            </div>
                            <div onClick={Auth} className="cursor-pointer w-[90.25px] h-[74px] px-[21.66px] py-[12.64px] bg-[#6B9CD6] rounded-[18.05px] drop-shadow-xl justify-center items-center gap-[5.42px] flex">
                                <Arrow/>
                            </div>
                        </div>
                        <Link to={"/search"}>
                            <div className="text-center text-[#6B9CD6] select-none cursor-pointer text-[28.88px] font-normal text_Jost underline">Войти позже</div>
                        </Link>
                    </div>
            </div>
        </div>
    );
};

export default IndexPage;