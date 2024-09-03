from flask import Flask, request, Response
from twilio.twiml.voice_response import VoiceResponse

app = Flask(__name__)

@app.route('/incoming-call', methods=['POST'])
def incoming_call():
    twiml = VoiceResponse()
    twiml.say('Thank you for calling. Your call will be recorded.')
    twiml.record(
        max_length=60,  # Set the maximum length of the recording
        action='/handle-recording'  # URL to handle the recording after it's done
    )
    return Response(str(twiml), mimetype='text/xml')

@app.route('/handle-recording', methods=['POST'])
def handle_recording():
    recording_url = request.form.get('RecordingUrl')
    print(f'Recording available at: {recording_url}')
    # Here you can save the recording URL to your database or process it further
    return Response(status=200)

if __name__ == '__main__':
    app.run(debug=True)