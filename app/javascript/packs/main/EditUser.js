import React from 'react'
import axios from 'axios'
import AjaxHelper from './AjaxHelper';

class EditUser extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      apiRequestHeaders: {},
      user_id: document.querySelector('#user-id').value,
      error: null,
      isLoaded: false,
      user: [],
      images: []
    };
  }

  componentDidMount() {
    var path = "/api/users/" + this.state.user_id
    AjaxHelper(path, this, "user");
  }


  addPicture = (e) => {
    var pics = new FormData();

    this.state.images.map(image => (
      pics.append('uploads[]', image[0])
    ))

    const options = {
      method:       'post',
      url:          '/api/users/' + this.state.user_id + '/pictures',
      headers:      this.apiRequestHeaders,
      data:         pics,
      responseType: 'json',
    }

    axios(options)
      .then(response => this.setState({user: response.data}))
      .then(
        this.setState({ images: [] }),
        document.querySelector('#images').value = ""
      )
      .catch(this._apiError)
  }

  _apiError = (error) => {
    console.log('Picture not loaded', error)
  }

  readFile = (e) => {
    var joined = this.state.images.concat(e.target.files);
    this.setState({ images: joined })
  }

  render() {
    const { error, isLoaded, user } = this.state;
    if (error) {
      return <div>Error: {error.message}</div>;
    } else if (!isLoaded) {
      return <div>Loading...</div>;
    } else {
      return (
        <div className="container">
          <div className="row text-center">
            <div className="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <h1 className="picture-title">Pictures</h1>
            </div>
            <div className="col-lg-12 col-md-12 col-sm-12 col-xs-12">
              <input name="images" type="file" id="images" onChange={(e) => {this.readFile(e)}} multiple/>
              <button className="btn btn-outline-primary" type="button" onClick={(e) => {this.addPicture(e)}}>Add</button>
            </div>
            <div className="col-lg-12 col-md-12 col-sm-12 col-xs-12">
              {this.state.images.map(image => (
                  <p>{image[0]["name"]}</p>
              ))}
            </div>
            <br/>
            { Object.keys(user["pictures"]).length == 0 ?
              <div className="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <p>No Pictures Uploaded</p>
              </div>
            :
              <div className="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                {user["pictures"].map(pic => (
                  <div className="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    {pic.map(image => (
                      <img src={image.file.url} width="200" height="200"/>
                    ))}
                  </div>
                ))}
              </div>
            }
          </div>
        </div>
      );
    }
  }
}

export default EditUser
