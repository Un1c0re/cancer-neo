import React, {useEffect, useMemo, useState} from 'react';
import {useDispatch, useSelector} from "react-redux";
import {useNavigate} from "react-router-dom";
import HeatMap from '@uiw/react-heat-map';
import {
    MaterialReactTable,
    useMaterialReactTable,
} from 'material-react-table';
const PatientPage = () => {
    const doctorId = useSelector(state => state.doctorId.doctorId)
    const patientId = useSelector(state => state.patientId.patientId)
    const patientName = useSelector(state => state.patientName.patientName)
    const attached = useSelector(state => state.attached.attached)
    const dispatch = useDispatch()
    const navigate = useNavigate();
    const [symptoms, setSymptoms] = useState([{}])
    const BACKEND_URL = import.meta.env.VITE_BACKEND_URL
    const value1 = [
        {
            "date": "2023/08/01",
            "count": 1
        },
        {
            "date": "2023/08/02",
            "count": 0
        },
        {
            "date": "2023/08/03",
            "count": 0
        },
        {
            "date": "2023/08/04",
            "count": 0
        },
        {
            "date": "2023/08/05",
            "count": 0
        },
        {
            "date": "2023/08/06",
            "count": 0
        },
        {
            "date": "2023/08/07",
            "count": 0
        },
        {
            "date": "2023/08/08",
            "count": 1
        },
        {
            "date": "2023/08/09",
            "count": 0
        },
        {
            "date": "2023/08/10",
            "count": 1
        },
        {
            "date": "2023/08/11",
            "count": 0
        },
        {
            "date": "2023/08/12",
            "count": 0
        },
        {
            "date": "2023/08/13",
            "count": 0
        },
        {
            "date": "2023/08/14",
            "count": 1
        },
        {
            "date": "2023/08/15",
            "count": 0
        },
        {
            "date": "2023/08/16",
            "count": 1
        },
        {
            "date": "2023/08/17",
            "count": 0
        },
        {
            "date": "2023/08/18",
            "count": 0
        },
        {
            "date": "2023/08/19",
            "count": 1
        },
        {
            "date": "2023/08/20",
            "count": 0
        },
        {
            "date": "2023/08/21",
            "count": 1
        },
        {
            "date": "2023/08/22",
            "count": 1
        },
        {
            "date": "2023/08/23",
            "count": 0
        },
        {
            "date": "2023/08/24",
            "count": 0
        },
        {
            "date": "2023/08/25",
            "count": 1
        },
        {
            "date": "2023/08/26",
            "count": 0
        },
        {
            "date": "2023/08/27",
            "count": 1
        },
        {
            "date": "2023/08/28",
            "count": 1
        },
        {
            "date": "2023/08/29",
            "count": 1
        },
        {
            "date": "2023/08/30",
            "count": 0
        },
        {
            "date": "2023/08/31",
            "count": 0
        },
        {
            "date": "2023/09/01",
            "count": 0
        },
        {
            "date": "2023/09/02",
            "count": 1
        },
        {
            "date": "2023/09/03",
            "count": 0
        },
        {
            "date": "2023/09/04",
            "count": 1
        },
        {
            "date": "2023/09/05",
            "count": 0
        },
        {
            "date": "2023/09/06",
            "count": 1
        },
        {
            "date": "2023/09/07",
            "count": 0
        },
        {
            "date": "2023/09/08",
            "count": 1
        },
        {
            "date": "2023/09/09",
            "count": 0
        },
        {
            "date": "2023/09/10",
            "count": 1
        },
        {
            "date": "2023/09/11",
            "count": 0
        },
        {
            "date": "2023/09/12",
            "count": 1
        },
        {
            "date": "2023/09/13",
            "count": 0
        },
        {
            "date": "2023/09/14",
            "count": 1
        },
        {
            "date": "2023/09/15",
            "count": 1
        },
        {
            "date": "2023/09/16",
            "count": 0
        },
        {
            "date": "2023/09/17",
            "count": 1
        },
        {
            "date": "2023/09/18",
            "count": 1
        },
        {
            "date": "2023/09/19",
            "count": 0
        },
        {
            "date": "2023/09/20",
            "count": 0
        },
        {
            "date": "2023/09/21",
            "count": 0
        },
        {
            "date": "2023/09/22",
            "count": 0
        },
        {
            "date": "2023/09/23",
            "count": 0
        },
        {
            "date": "2023/09/24",
            "count": 0
        },
        {
            "date": "2023/09/25",
            "count": 1
        },
        {
            "date": "2023/09/26",
            "count": 1
        },
        {
            "date": "2023/09/27",
            "count": 1
        },
        {
            "date": "2023/09/28",
            "count": 1
        },
        {
            "date": "2023/09/29",
            "count": 0
        },
        {
            "date": "2023/09/30",
            "count": 0
        },
        {
            "date": "2023/10/01",
            "count": 0
        },
        {
            "date": "2023/10/02",
            "count": 0
        },
        {
            "date": "2023/10/03",
            "count": 0
        },
        {
            "date": "2023/10/04",
            "count": 0
        },
        {
            "date": "2023/10/05",
            "count": 0
        },
        {
            "date": "2023/10/06",
            "count": 1
        },
        {
            "date": "2023/10/07",
            "count": 0
        },
        {
            "date": "2023/10/08",
            "count": 0
        },
        {
            "date": "2023/10/09",
            "count": 0
        },
        {
            "date": "2023/10/10",
            "count": 0
        },
        {
            "date": "2023/10/11",
            "count": 0
        },
        {
            "date": "2023/10/12",
            "count": 0
        },
        {
            "date": "2023/10/13",
            "count": 0
        },
        {
            "date": "2023/10/14",
            "count": 0
        },
        {
            "date": "2023/10/15",
            "count": 1
        },
        {
            "date": "2023/10/16",
            "count": 0
        },
        {
            "date": "2023/10/17",
            "count": 1
        },
        {
            "date": "2023/10/18",
            "count": 0
        },
        {
            "date": "2023/10/19",
            "count": 0
        },
        {
            "date": "2023/10/20",
            "count": 1
        },
        {
            "date": "2023/10/21",
            "count": 0
        },
        {
            "date": "2023/10/22",
            "count": 0
        },
        {
            "date": "2023/10/23",
            "count": 1
        },
        {
            "date": "2023/10/24",
            "count": 1
        },
        {
            "date": "2023/10/25",
            "count": 0
        },
        {
            "date": "2023/10/26",
            "count": 1
        },
        {
            "date": "2023/10/27",
            "count": 0
        },
        {
            "date": "2023/10/28",
            "count": 1
        },
        {
            "date": "2023/10/29",
            "count": 1
        },
        {
            "date": "2023/10/30",
            "count": 0
        },
        {
            "date": "2023/10/31",
            "count": 1
        },
        {
            "date": "2023/11/01",
            "count": 2
        },
        {
            "date": "2023/11/02",
            "count": 4
        },
        {
            "date": "2023/11/03",
            "count": 1
        },
        {
            "date": "2023/11/04",
            "count": 1
        },
        {
            "date": "2023/11/05",
            "count": 0
        },
        {
            "date": "2023/11/06",
            "count": 1
        },
        {
            "date": "2023/11/07",
            "count": 1
        },
        {
            "date": "2023/11/08",
            "count": 1
        },
        {
            "date": "2023/11/09",
            "count": 1
        },
        {
            "date": "2023/11/10",
            "count": 0
        },
        {
            "date": "2023/11/11",
            "count": 5
        },
        {
            "date": "2023/11/12",
            "count": 4
        },
        {
            "date": "2023/11/13",
            "count": 6
        },
        {
            "date": "2023/11/14",
            "count": 1
        },
        {
            "date": "2023/11/15",
            "count": 0
        },
        {
            "date": "2023/11/16",
            "count": 1
        },
        {
            "date": "2023/11/17",
            "count": 1
        },
        {
            "date": "2023/11/18",
            "count": 0
        },
        {
            "date": "2023/11/19",
            "count": 1
        },
        {
            "date": "2023/11/20",
            "count": 1
        },
        {
            "date": "2023/11/21",
            "count": 1
        },
        {
            "date": "2023/11/22",
            "count": 1
        },
        {
            "date": "2023/11/23",
            "count": 0
        },
        {
            "date": "2023/11/24",
            "count": 0
        },
        {
            "date": "2023/11/25",
            "count": 1
        },
        {
            "date": "2023/11/26",
            "count": 1
        },
        {
            "date": "2023/11/27",
            "count": 1
        },
        {
            "date": "2023/11/28",
            "count": 1
        },
        {
            "date": "2023/11/29",
            "count": 0
        },
        {
            "date": "2023/11/30",
            "count": 0
        },
        {
            "date": "2023/12/01",
            "count": 1
        },
        {
            "date": "2023/12/02",
            "count": 1
        },
        {
            "date": "2023/12/03",
            "count": 1
        },
        {
            "date": "2023/12/04",
            "count": 1
        },
        {
            "date": "2023/12/05",
            "count": 1
        },
        {
            "date": "2023/12/06",
            "count": 0
        },
        {
            "date": "2023/12/07",
            "count": 1
        },
        {
            "date": "2023/12/08",
            "count": 0
        },
        {
            "date": "2023/12/09",
            "count": 1
        },
        {
            "date": "2023/12/10",
            "count": 1
        },
        {
            "date": "2023/12/11",
            "count": 0
        },
        {
            "date": "2023/12/12",
            "count": 1
        },
        {
            "date": "2023/12/13",
            "count": 1
        },
        {
            "date": "2023/12/14",
            "count": 0
        },
        {
            "date": "2023/12/15",
            "count": 0
        },
        {
            "date": "2023/12/16",
            "count": 1
        },
        {
            "date": "2023/12/17",
            "count": 0
        },
        {
            "date": "2023/12/18",
            "count": 1
        },
        {
            "date": "2023/12/19",
            "count": 0
        },
        {
            "date": "2023/12/20",
            "count": 0
        },
        {
            "date": "2023/12/21",
            "count": 1
        },
        {
            "date": "2023/12/22",
            "count": 0
        },
        {
            "date": "2023/12/23",
            "count": 0
        },
        {
            "date": "2023/12/24",
            "count": 1
        },
        {
            "date": "2023/12/25",
            "count": 1
        },
        {
            "date": "2023/12/26",
            "count": 0
        },
        {
            "date": "2023/12/27",
            "count": 1
        },
        {
            "date": "2023/12/28",
            "count": 1
        },
        {
            "date": "2023/12/29",
            "count": 0
        },
        {
            "date": "2023/12/30",
            "count": 0
        }
    ]
    const value = [
        {
            "date": "2023/11/11",
            "count": 5
        },
        {
            "date": "2023/11/12",
            "count": 3
        },
        {
            "date": "2023/11/13",
            "count": 3
        },
        {
            "date": "2023/11/11",
            "count": 6
        },
        {
            "date": "2023/11/01",
            "count": 0
        },
        {
            "date": "2023/11/02",
            "count": 8
        },
        {
            "date": "2023/11/04",
            "count": 3
        },
        {
            "date": "2023/12/09",
            "count": 6
        },
        {
            "date": "2023/10/05",
            "count": 7
        },
        {
            "date": "2023/08/04",
            "count": 5
        },
        {
            "date": "2023/08/25",
            "count": 6
        },
        {
            "date": "2023/08/30",
            "count": 3
        },
        {
            "date": "2023/08/21",
            "count": 7
        },
        {
            "date": "2023/09/01",
            "count": 4
        },
        {
            "date": "2023/12/15",
            "count": 3
        },
        {
            "date": "2023/09/17",
            "count": 3
        },
        {
            "date": "2023/11/27",
            "count": 3
        },
        {
            "date": "2023/11/22",
            "count": 6
        },
        {
            "date": "2023/10/16",
            "count": 3
        },
        {
            "date": "2023/09/13",
            "count": 5
        },
        {
            "date": "2023/12/04",
            "count": 4
        },
        {
            "date": "2023/10/07",
            "count": 5
        },
        {
            "date": "2023/11/03",
            "count": 1
        },
        {
            "date": "2023/09/21",
            "count": 7
        },
        {
            "date": "2023/09/21",
            "count": 7
        },
        {
            "date": "2023/10/11",
            "count": 6
        },
        {
            "date": "2023/10/18",
            "count": 7
        },
        {
            "date": "2023/08/21",
            "count": 1
        },
        {
            "date": "2023/12/04",
            "count": 2
        },
        {
            "date": "2023/12/22",
            "count": 4
        },
        {
            "date": "2023/10/30",
            "count": 8
        },
        {
            "date": "2023/10/13",
            "count": 3
        },
        {
            "date": "2023/08/25",
            "count": 7
        },
        {
            "date": "2023/12/16",
            "count": 4
        },
        {
            "date": "2023/11/27",
            "count": 8
        },
        {
            "date": "2023/10/24",
            "count": 3
        },
        {
            "date": "2023/08/13",
            "count": 0
        },
        {
            "date": "2023/10/27",
            "count": 1
        },
        {
            "date": "2023/08/28",
            "count": 2
        },
        {
            "date": "2023/11/15",
            "count": 6
        },
        {
            "date": "2023/09/11",
            "count": 6
        },
        {
            "date": "2023/09/29",
            "count": 1
        },
        {
            "date": "2023/09/17",
            "count": 1
        },
        {
            "date": "2023/11/18",
            "count": 2
        },
        {
            "date": "2023/12/15",
            "count": 6
        },
        {
            "date": "2023/11/03",
            "count": 1
        },
        {
            "date": "2023/08/07",
            "count": 6
        },
        {
            "date": "2023/11/14",
            "count": 8
        },
        {
            "date": "2023/10/02",
            "count": 3
        },
        {
            "date": "2023/08/31",
            "count": 0
        },
        {
            "date": "2023/12/05",
            "count": 6
        },
        {
            "date": "2023/08/15",
            "count": 5
        },
        {
            "date": "2023/09/11",
            "count": 5
        },
        {
            "date": "2023/08/03",
            "count": 4
        },
        {
            "date": "2023/09/27",
            "count": 1
        },
        {
            "date": "2023/08/08",
            "count": 3
        },
        {
            "date": "2023/10/19",
            "count": 4
        },
        {
            "date": "2023/10/22",
            "count": 3
        },
        {
            "date": "2023/12/26",
            "count": 5
        },
        {
            "date": "2023/11/14",
            "count": 7
        },
        {
            "date": "2023/08/07",
            "count": 5
        },
        {
            "date": "2023/11/05",
            "count": 8
        },
        {
            "date": "2023/12/27",
            "count": 2
        },
        {
            "date": "2023/08/18",
            "count": 1
        },
        {
            "date": "2023/09/01",
            "count": 1
        },
        {
            "date": "2023/12/04",
            "count": 5
        },
        {
            "date": "2023/10/10",
            "count": 6
        },
        {
            "date": "2023/11/15",
            "count": 4
        },
        {
            "date": "2023/11/17",
            "count": 8
        },
        {
            "date": "2023/08/02",
            "count": 1
        },
        {
            "date": "2023/08/09",
            "count": 4
        },
        {
            "date": "2023/08/06",
            "count": 4
        },
        {
            "date": "2023/12/30",
            "count": 0
        },
        {
            "date": "2023/12/25",
            "count": 6
        },
        {
            "date": "2023/08/21",
            "count": 0
        },
        {
            "date": "2023/11/18",
            "count": 6
        },
        {
            "date": "2023/12/03",
            "count": 6
        },
        {
            "date": "2023/12/02",
            "count": 6
        },
        {
            "date": "2023/09/21",
            "count": 5
        },
        {
            "date": "2023/12/13",
            "count": 2
        },
        {
            "date": "2023/12/18",
            "count": 3
        },
        {
            "date": "2023/09/10",
            "count": 5
        },
        {
            "date": "2023/11/09",
            "count": 4
        },
        {
            "date": "2023/08/20",
            "count": 1
        },
        {
            "date": "2023/11/19",
            "count": 2
        },
        {
            "date": "2023/11/22",
            "count": 1
        },
        {
            "date": "2023/11/06",
            "count": 7
        },
        {
            "date": "2023/08/20",
            "count": 8
        },
        {
            "date": "2023/12/04",
            "count": 3
        },
        {
            "date": "2023/11/27",
            "count": 1
        },
        {
            "date": "2023/11/14",
            "count": 5
        },
        {
            "date": "2023/10/10",
            "count": 8
        },
        {
            "date": "2023/08/27",
            "count": 1
        },
        {
            "date": "2023/08/09",
            "count": 7
        },
        {
            "date": "2023/11/07",
            "count": 2
        },
        {
            "date": "2023/09/23",
            "count": 8
        },
        {
            "date": "2023/09/26",
            "count": 2
        },
        {
            "date": "2023/12/03",
            "count": 6
        },
        {
            "date": "2023/08/19",
            "count": 4
        },
        {
            "date": "2023/10/30",
            "count": 1
        },
        {
            "date": "2023/10/07",
            "count": 6
        },
        {
            "date": "2023/08/02",
            "count": 1
        },
        {
            "date": "2023/08/01",
            "count": 4
        },
        {
            "date": "2023/11/19",
            "count": 3
        },
        {
            "date": "2023/12/11",
            "count": 4
        },
        {
            "date": "2023/09/06",
            "count": 6
        },
        {
            "date": "2023/09/06",
            "count": 0
        }
    ];

    // useEffect(() => {
    //     if(patientId.length === 0){
    //         navigate("/search")
    //     }
    //     else{
    //         fetch(BACKEND_URL + `/patient/${patientId}/symptoms`)
    //             .then(response => response.json())
    //             .then(data => setSymptoms(data))
    //     }
    // }, []);
    const attachPatient = () => {
        fetch(BACKEND_URL + "/doctor/patient/bind/"
            , {
                method: "POST",
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({patient_id: patientId, doctor_id: doctorId})
            })
            .then(response => response.json())
            .then(() => {
                    dispatch({type: "CHANGE_VALUE_ATTACHED", payload: doctorId})
            })
    }
    return (
        <div className="w-screen min-h-screen">
            <div className="bg-zinc-100 w-full flex-col justify-start items-start inline-flex">
                <div className="self-stretch w-full space-between px-[30px] py-3 bg-sky-100 justify-between items-center inline-flex">
                    <div className="flex-col justify-center items-center inline-flex">
                        <div className="text-center text-[#6B9CD6] text-[39.38px] font-bold text_Jost">NeoCancer</div>
                        <div className="text-center text-[#6B9CD6] text-lg font-normal text_Jost">для врачей</div>
                    </div>
                    <div className="px-[15px] py-2.5 rounded-[58px] border border-zinc-500 justify-center items-center gap-5 flex">
                        <div className="text-center text-zinc-500 text-3xl font-normal text_Jost">октябрь &ndash; ноябрь 2023</div>
                    </div>
                    {attached === 0 ?
                    <div onClick={attachPatient} className="select-none cursor-pointer text-center text-white p-5 text-3xl font-normal text_Jost bg-[#6B9CD6] rounded-[24px]">
                        Прикрепить пациента
                    </div> : <></>}
                    <div className="text-center text-zinc-500 text-3xl font-normal text_Jost">Пациент: {patientName}</div>
                </div>
                <div className="self-stretch grow shrink basis-0 p-[50px] justify-center items-center gap-10 flex-col flex">
                    <div className="flex-row justify-center items-center gap-[50px] inline-flex">
                        <div className="bg-white shadow flex-col justify-start items-center flex">
                            <div className="self-stretch h-[100px] p-2.5 bg-blue-300 justify-center items-center gap-2.5 inline-flex">
                                <div className="text-center text-white text-[35px] font-normal text_Jost">Слабость, утомляемость</div>
                            </div>
                            <div className="p-8">
                                <HeatMap
                                    value={value}
                                    weekLabels={['', 'Пн', '', 'Ср', '', 'Пт', '']}
                                    startDate={new Date('2023/08/01')}
                                    endDate={new Date('2023/12/30')}
                                    legendCellSize={0}
                                    rectSize={15}
                                    panelColors={{
                                        0: '#f0f0f0',
                                        2: '#4caf50',
                                        4: '#ffa500',
                                        6: '#f44336',
                                        8: '#ad001d',
                                    }}
                                />
                            </div>
                        </div>
                        <div className="bg-white shadow flex-col justify-start items-start flex">
                            <div className="self-stretch h-[100px] p-2.5 bg-emerald-300 justify-center items-center gap-2.5 inline-flex">
                                <div className="text-center text-white text-[35px] font-normal text_Jost">Болевой синдром</div>
                            </div>
                            <div className="p-8">
                                <HeatMap
                                    value={value}
                                    weekLabels={['', 'Пн', '', 'Ср', '', 'Пт', '']}
                                    startDate={new Date('2023/08/01')}
                                    endDate={new Date('2023/12/30')}
                                    legendCellSize={0}
                                    rectSize={15}
                                    panelColors={{
                                        0: '#f0f0f0',
                                        2: '#4caf50',
                                        4: '#ffa500',
                                        6: '#f44336',
                                        8: '#ad001d',
                                    }}
                                />
                            </div>
                        </div>
                        <div className="bg-white shadow flex-col justify-start items-start flex">
                            <div className="self-stretch h-[100px] p-2.5 bg-orange-300 justify-center items-center gap-2.5 inline-flex">
                                <div className="text-center text-white text-[35px] font-normal text_Jost">Депрессия, тревога</div>
                            </div>
                            <div className="p-8">
                                <HeatMap
                                    value={value}
                                    weekLabels={['', 'Пн', '', 'Ср', '', 'Пт', '']}
                                    startDate={new Date('2023/08/01')}
                                    endDate={new Date('2023/12/30')}
                                    legendCellSize={0}
                                    rectSize={15}
                                    panelColors={{
                                        0: '#f0f0f0',
                                        2: '#4caf50',
                                        4: '#ffa500',
                                        6: '#f44336',
                                        8: '#ad001d',
                                    }}
                                />
                            </div>
                        </div>
                    </div>
                    <div className="flex-row justify-center items-center gap-[50px] inline-flex">
                        <div className="bg-white shadow flex-col justify-start items-center flex">
                            <div className="self-stretch h-[100px] p-2.5 bg-blue-300 justify-center items-center gap-2.5 inline-flex">
                                <div className="text-center text-white text-[35px] font-normal text_Jost">Рвота</div>
                            </div>
                            <div className="p-8">
                                <HeatMap
                                    value={value1}
                                    weekLabels={['', 'Пн', '', 'Ср', '', 'Пт', '']}
                                    startDate={new Date('2023/08/01')}
                                    endDate={new Date('2023/12/30')}
                                    legendCellSize={0}
                                    rectSize={15}
                                    panelColors={{
                                        1: '#f0f0f0',
                                        3: '#f44336',
                                    }}
                                />
                            </div>
                        </div>
                        <div className="bg-white shadow flex-col justify-start items-start flex">
                            <div className="self-stretch h-[100px] p-2.5 bg-emerald-300 justify-center items-center gap-2.5 inline-flex">
                                <div className="text-center text-white text-[35px] font-normal text_Jost">Уменьшение диуреза</div>
                            </div>
                            <div className="p-8">
                                <HeatMap
                                    value={value1}
                                    weekLabels={['', 'Пн', '', 'Ср', '', 'Пт', '']}
                                    startDate={new Date('2023/08/01')}
                                    endDate={new Date('2023/12/30')}
                                    legendCellSize={0}
                                    rectSize={15}
                                    panelColors={{
                                        1: '#f0f0f0',
                                        3: '#f44336',
                                    }}
                                />
                            </div>
                        </div>
                        <div className="bg-white shadow flex-col justify-start items-start flex">
                            <div className="self-stretch h-[100px] p-2.5 bg-orange-300 justify-center items-center gap-2.5 inline-flex">
                                <div className="text-center text-white text-[35px] font-normal text_Jost">Ухудшение памяти</div>
                            </div>
                            <div className="p-8">
                                <HeatMap
                                    value={value1}
                                    weekLabels={['', 'Пн', '', 'Ср', '', 'Пт', '']}
                                    startDate={new Date('2023/08/01')}
                                    endDate={new Date('2023/12/30')}
                                    legendCellSize={0}
                                    rectSize={15}
                                    panelColors={{
                                        1: '#f0f0f0',
                                        3: '#f44336',
                                    }}
                                />
                            </div>
                        </div>
                    </div>
                    <div className="flex-row justify-center items-center gap-[50px] inline-flex">
                        <div className="bg-white shadow flex-col justify-start items-center flex">
                            <div className="self-stretch h-[100px] p-2.5 bg-blue-300 justify-center items-center gap-2.5 inline-flex">
                                <div className="text-center text-white text-[35px] font-normal text_Jost">Нарушение моторных функций</div>
                            </div>
                            <div className="p-8">
                                <HeatMap
                                    value={value1}
                                    weekLabels={['', 'Пн', '', 'Ср', '', 'Пт', '']}
                                    startDate={new Date('2023/08/01')}
                                    endDate={new Date('2023/12/30')}
                                    legendCellSize={0}
                                    rectSize={15}
                                    panelColors={{
                                        1: '#f0f0f0',
                                        3: '#f44336',
                                    }}
                                />
                            </div>
                        </div>
                        <div className="bg-white shadow flex-col justify-start items-start flex">
                            <div className="self-stretch h-[100px] p-2.5 bg-emerald-300 justify-center items-center gap-2.5 inline-flex">
                                <div className="text-center text-white text-[35px] font-normal text_Jost">Хрипы</div>
                            </div>
                            <div className="p-8">
                                <HeatMap
                                    value={value1}
                                    weekLabels={['', 'Пн', '', 'Ср', '', 'Пт', '']}
                                    startDate={new Date('2023/08/01')}
                                    endDate={new Date('2023/12/30')}
                                    legendCellSize={0}
                                    rectSize={15}
                                    panelColors={{
                                        1: '#f0f0f0',
                                        3: '#f44336',
                                    }}
                                />
                            </div>
                        </div>
                        <div className="bg-white shadow flex-col justify-start items-start flex">
                            <div className="self-stretch h-[100px] p-2.5 bg-orange-300 justify-center items-center gap-2.5 inline-flex">
                                <div className="text-center text-white text-[35px] font-normal text_Jost">Бронхоспазм</div>
                            </div>
                            <div className="p-8">
                                <HeatMap
                                    value={value1}
                                    weekLabels={['', 'Пн', '', 'Ср', '', 'Пт', '']}
                                    startDate={new Date('2023/08/01')}
                                    endDate={new Date('2023/12/30')}
                                    legendCellSize={0}
                                    rectSize={15}
                                    panelColors={{
                                        1: '#f0f0f0',
                                        3: '#f44336',
                                    }}
                                />
                            </div>
                        </div>
                    </div>
                    <div className="flex-row justify-center items-center gap-[50px] inline-flex">
                        <div className="bg-white shadow flex-col justify-start items-center flex">
                            <div className="self-stretch h-[100px] p-2.5 bg-blue-300 justify-center items-center gap-2.5 inline-flex">
                                <div className="text-center text-white text-[35px] font-normal text_Jost">Боль в левой части грудной клетки</div>
                            </div>
                            <div className="p-8">
                                <HeatMap
                                    value={value1}
                                    weekLabels={['', 'Пн', '', 'Ср', '', 'Пт', '']}
                                    startDate={new Date('2023/08/01')}
                                    endDate={new Date('2023/12/30')}
                                    legendCellSize={0}
                                    rectSize={15}
                                    panelColors={{
                                        1: '#f0f0f0',
                                        3: '#f44336',
                                    }}
                                />
                            </div>
                        </div>
                        <div className="bg-white shadow flex-col justify-start items-start flex">
                            <div className="self-stretch h-[100px] p-2.5 bg-emerald-300 justify-center items-center gap-2.5 inline-flex">
                                <div className="text-center text-white text-[35px] font-normal text_Jost">Аритмия</div>
                            </div>
                            <div className="p-8">
                                <HeatMap
                                    value={value1}
                                    weekLabels={['', 'Пн', '', 'Ср', '', 'Пт', '']}
                                    startDate={new Date('2023/08/01')}
                                    endDate={new Date('2023/12/30')}
                                    legendCellSize={0}
                                    rectSize={15}
                                    panelColors={{
                                        1: '#f0f0f0',
                                        3: '#f44336',
                                    }}
                                />
                            </div>
                        </div>
                        <div className="bg-white shadow flex-col justify-start items-start flex">
                            <div className="self-stretch h-[100px] p-2.5 bg-orange-300 justify-center items-center gap-2.5 inline-flex">
                                <div className="text-center text-white text-[35px] font-normal text_Jost">Спутанность сознания (химический мозг)</div>
                            </div>
                            <div className="p-8 justify-center items-center flex w-full">
                                <HeatMap
                                    value={value1}
                                    weekLabels={['', 'Пн', '', 'Ср', '', 'Пт', '']}
                                    startDate={new Date('2023/08/01')}
                                    endDate={new Date('2023/12/30')}
                                    legendCellSize={0}
                                    rectSize={15}
                                    panelColors={{
                                        1: '#f0f0f0',
                                        3: '#f44336',
                                    }}
                                />
                            </div>
                        </div>
                    </div>
                    <div className="flex-row justify-center items-center gap-[50px] inline-flex">
                        <div className="bg-white shadow flex-col justify-start items-center flex">
                            <div className="self-stretch h-[100px] p-2.5 bg-blue-300 justify-center items-center gap-2.5 inline-flex">
                                <div className="text-center text-white text-[35px] font-normal text_Jost">Прилив жара в верхней части туловища</div>
                            </div>
                            <div className="p-8">
                                <HeatMap
                                    value={value1}
                                    weekLabels={['', 'Пн', '', 'Ср', '', 'Пт', '']}
                                    startDate={new Date('2023/08/01')}
                                    endDate={new Date('2023/12/30')}
                                    legendCellSize={0}
                                    rectSize={15}
                                    panelColors={{
                                        1: '#f0f0f0',
                                        3: '#f44336',
                                    }}
                                />
                            </div>
                        </div>
                        <div className="bg-white shadow flex-col justify-start items-start flex">
                            <div className="self-stretch h-[100px] p-2.5 bg-emerald-300 justify-center items-center gap-2.5 inline-flex">
                                <div className="text-center text-white text-[35px] font-normal text_Jost">Нейродермит (сыпь, зуд)</div>
                            </div>
                            <div className="p-8">
                                <HeatMap
                                    value={value1}
                                    weekLabels={['', 'Пн', '', 'Ср', '', 'Пт', '']}
                                    startDate={new Date('2023/08/01')}
                                    endDate={new Date('2023/12/30')}
                                    legendCellSize={0}
                                    rectSize={15}
                                    panelColors={{
                                        1: '#f0f0f0',
                                        3: '#f44336',
                                    }}
                                />
                            </div>
                        </div>
                        <div className="bg-white shadow flex-col justify-start items-start flex">
                            <div className="self-stretch h-[100px] p-2.5 bg-orange-300 justify-center items-center gap-2.5 inline-flex">
                                <div className="text-center text-white text-[35px] font-normal text_Jost">Стоматит</div>
                            </div>
                            <div className="p-8">
                                <HeatMap
                                    value={value1}
                                    weekLabels={['', 'Пн', '', 'Ср', '', 'Пт', '']}
                                    startDate={new Date('2023/08/01')}
                                    endDate={new Date('2023/12/30')}
                                    legendCellSize={0}
                                    rectSize={15}
                                    panelColors={{
                                        1: '#f0f0f0',
                                        3: '#f44336',
                                    }}
                                />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default PatientPage;