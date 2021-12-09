pragma solidity >=0.7.0 <0.9.0;



contract MyContract{
    
    struct User {
        string name;
        string gender;
        uint year_of_birth;
        bool present;
    }

// data of patient in every visit

    struct patdata {
        string date;
        string problem;
        uint pulse;
        uint spo2;
        uint temp;
        string doctor_name;
        string prescription;
    }

    mapping (uint => patdata[]) patdatabase;
    
    mapping(uint => User) patients;
    
    uint a = 0;
    
    function create_new_patient(string memory _name, string memory _gender, uint _yob) internal {
        a++;
        User memory patient = User(_name, _gender, _yob, true);
        patients[a] = patient;
    }

    

    function patient_exist(uint id) internal view returns(bool) {
        if(patients[id].present == false){
            return false;
        }else{
            return true;
        }
    }

    function add_patient_details(string memory _name, uint id, uint _yob,  string memory pat_gender, string memory curr_date, uint pat_pulse, uint pat_spo2, uint pat_temp, string memory doctors_name, string memory _problem, string memory _prescription) public{
        
        if(patient_exist(id)==true){
            
            patdata memory newentry;
            
            newentry.date = curr_date;
            newentry.problem = _problem;
            newentry.pulse = pat_pulse;
            newentry.spo2 = pat_spo2; 
            newentry.doctor_name = doctors_name;
            newentry.temp = pat_temp;
            newentry.prescription = _prescription;

            patdatabase[id].push(newentry);
             
        }else{
            
            create_new_patient(_name, pat_gender, _yob);

            patdata memory newentry;
            
            newentry.date = curr_date;
            newentry.problem = _problem;
            newentry.pulse = pat_pulse;
            newentry.spo2 = pat_spo2;
            newentry.doctor_name = doctors_name;
            newentry.temp = pat_temp;
            newentry.prescription = _prescription;

            patdatabase[a].push(newentry);

        }
    }

        // sequence => date, problem, temperature, pulserate, spo2 level, doctors name, prescription.

    function get_pateint_history(uint id, uint num) public view returns(string memory, string memory, uint, uint, uint, string memory, string memory){
        patdata[] memory p = patdatabase[id];
        uint ind = p.length - num;
        return(p[ind].date, p[ind].problem, p[ind].temp, p[ind].pulse, p[ind].spo2, p[ind].doctor_name, p[ind].prescription ); 
    }



    function get_pateint_details(uint id) public view returns(string memory, uint, string memory){
        User memory user = patients[id];
        return(user.name, user.year_of_birth, user.gender);
    }
}
