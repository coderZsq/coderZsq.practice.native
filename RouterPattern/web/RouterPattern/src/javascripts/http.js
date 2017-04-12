import axios from 'axios'

export function GET(url) {

  return new Promise((resolve, reject) => {
    axios.get(url).then((response) => {
      resolve(response.data.data);
    }).catch((error) => {
      reject(error);
    })
  });
}

export const URL = {
  getJ1List: 'http://localhost:3001/api/J1/getJ1List'
}
