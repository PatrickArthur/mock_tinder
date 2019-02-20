import React from 'react'
import AjaxHelper from './AjaxHelper';

class ActivityFeed extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      apiRequestHeaders: {},
      user_id: document.querySelector('#user-id').value,
      error: null,
      isLoaded: false,
      feed: [],
    };
  }

  componentDidMount() {
    var path = "/api/users/" + this.state.user_id + "/activity_feed/"
    AjaxHelper(path, this, "feed");
  }

  render() {
    const { error, isLoaded, feed } = this.state;
    if (error) {
      return <div>Error: {error.message}</div>;
    } else if (!isLoaded) {
      return <div>Loading...</div>;
    } else {
      return (
        <div className="container">
          <div className="row text-center">
            <div className="col-lg-12 col-md-12 col-sm-12 col-xs-12">
              <h4>Activity Feed</h4>
            </div>
            { Object.keys(feed).length == 0 ?
              <div className="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                  <h1>No Photos Voted</h1>
              </div>
            :
              <div className="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                {feed.map((item, index) => (
                  <ul>
                    {item.votes.map((vote, index) =><li><img src={vote.picture.file.url} width="50" height="50"/> --------- {vote.email} - {vote.time}</li>)}
                  </ul>
                ))}
              </div>
            }
          </div>
        </div>
      );
    }
  }
}

export default ActivityFeed
