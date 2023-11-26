import React from 'react';
import {useNavigate} from "react-router-dom";
import {useDispatch} from "react-redux";

const PatientCard = ({name, id, date, attached}) => {
    const navigate = useNavigate();
    const dispatch = useDispatch()
    const checkPatient = () => {
        dispatch({type: "CHANGE_VALUE_PATIENTID", payload: id})
        dispatch({type: "CHANGE_VALUE_PATIENTNAME", payload: name})
        dispatch({type: "CHANGE_VALUE_ATTACHED", payload: attached})
        navigate("/patient")
    }

    return (
        <div>
            <div onClick={checkPatient} className="select-none cursor-pointer w-full flex self-stretch h-[60px] p-2.5 border-b border-zinc-500 justify-between items-center inline-flex">
                <div className="text-center text-zinc-500 text-xl font-normal text_Jost">{name}</div>
                <div className="text-center text-zinc-500 text-xl font-normal text_Jost">{date}</div>
            </div>
        </div>
    );
};

export default PatientCard;