class TokenUser{
    constructor(){
        
    }
    static getName(){
        return JSON.parse(sessionStorage.getItem("token")).name;
    }
    static getType(){
        return parseInt(JSON.parse(sessionStorage.getItem("token")).user_type);
    }
    static getUserId(){
        return parseInt(JSON.parse(sessionStorage.getItem("token")).user_id);
    }
    static getToken(){
        return JSON.parse(sessionStorage.getItem("token")).token;
    }

    static getHeaderToken(){
        return {
            headers: {
                "Authorization": this.getToken()
            }
        };
    }
}

export default TokenUser;