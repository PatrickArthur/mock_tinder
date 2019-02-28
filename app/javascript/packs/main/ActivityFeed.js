import React from 'react'
import AjaxHelper from './shared/AjaxHelper'
import DateFormat from './shared/DateFormat'

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
              <h2>Activity Feed</h2>
            </div>
            { feed.length == 0 ?
              <div className="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <h4>No Photos Voted</h4>
              </div>
            :
              <div className="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <table className="table">
                  <thead>
                    <tr>
                      <th></th>
                      <th>User</th>
                      <th>Voted At</th>
                    </tr>
                  </thead>
                  <tbody>
                    {feed.map(item => (
                      <tr>
                        <td><img src={item.file.url} width="50" height="50"/></td>
                        <td>{item.email}</td>
                        <td>{DateFormat(item.created_at)}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            }
          </div>
        </div>
      );
    }
  }
}

export default ActivityFeed
