import axios from "axios";

const host = "avaliauto-backend.azurewebsites.net";
const port = "80";


const api = axios.create({
    baseURL:`http://${host}:${port}`
});

export default api;
