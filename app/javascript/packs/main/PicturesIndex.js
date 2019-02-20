import React from 'react'
import axios from 'axios'
import AjaxHelper from './AjaxHelper';

class PicturesIndex extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      apiRequestHeaders: {},
      error: null,
      isLoaded: false,
      picture: null
    };
  }

  componentDidMount() {
    AjaxHelper("/api/pictures/", this, "picture");
  }

  LikedDislikeVote = (e) => {
    var photo_id = document.querySelector('#photo_id').value
    var path = ""
    var data = {}

    if (e.target.id != "vote") {
      path = '/api/pictures/' + photo_id + "/likes"
      var like_object = false

      if (e.target.id == "liked") {
        like_object = true
      }

      data["like_object"] = like_object
    } else {
      path = '/api/pictures/' + photo_id + "/votes"
      data["vote"] = true
    }

    const options = {
      method:       'post',
      url:          path,
      headers:      this.apiRequestHeaders,
      data:         data,
      responseType: 'json',
    }

    axios(options)
      .then(response => this.setState({picture: response.data}))
      .catch(this._apiError)
  }

  _apiError = (error) => {
    console.log('Picture not loaded', error)
  }

  render() {
    const { error, isLoaded, picture } = this.state;
    if (error) {
      return <div>Error: {error.message}</div>;
    } else if (!isLoaded) {
      return <div>Loading...</div>;
    } else {
      return (
        <div className="container">
        <br/>
        <br/>
        <br/>
          <div className="row text-center">
            { picture == null ?
              <div className="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                  <h1>No Pictures</h1>
              </div>
            :
              <div className="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div className="col-lg-9 col-md-9 col-sm-9 col-xs-9">
                  <button className="btn btn-outline-primary" id="liked" type="button" onClick={(e) => {this.LikedDislikeVote(e)}}>Like</button>
                  <button className="btn btn-outline-primary" id="disliked" type="button" onClick={(e) => {this.LikedDislikeVote(e)}}>Dislike</button>
                  <button className="btn btn-outline-primary" id="vote" type="button" onClick={(e) => {this.LikedDislikeVote(e)}}>Vote</button>
                </div>
                <br/>
                <br/>
                <img src={picture["file"]["url"]} width="460" height="460"/>
                <input type="hidden" id="photo_id" name="photo_id" value={picture["id"]}/>
              </div>
            }
          </div>
        </div>
      );
    }
  }
}

export default PicturesIndex
