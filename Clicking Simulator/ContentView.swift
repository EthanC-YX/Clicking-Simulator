import SwiftUI

struct ContentView: View {
    
    @State private var clicks = 0
    @State private var clicksPerClick = 1
    @State private var showAlert = false
    @State var buttons = [ // Your list of buttons should be defined here from another file
        ListOfButtons(title: "Better Mouse!", subtitle: "Buy a new mouse to increase your click speed!", amountOfClickIncrease: 3, cost: 50),
        ListOfButtons(title: "New Gaming Chair!", subtitle: "Improve your experience with a Gaming Chair!", amountOfClickIncrease: 5, cost: 200),
        ListOfButtons(title: "Triple Monitor Setup!", subtitle: "Buy 3 monitors to significantly increase your clicks!", amountOfClickIncrease: 20, cost: 700),
        ListOfButtons(title: "Helping Hand!", subtitle: "Hire a worker to help you with your clicking journey!", cost: 1500, autoClick: 10),
        ListOfButtons(title: "Pet Robot", subtitle: "A cute little robot to help you in your clicking journey!", cost: 3500, autoClick: 30),
        ListOfButtons(title: "Investors!", subtitle: "Sell shares of your clicks to willing investors!", amountOfClickIncrease: 100, cost: 7000),
        ListOfButtons(title: "Start a Clicking Business", subtitle: "Someone recommends you to start a clicking business and it goes great!", amountOfClickIncrease: 500, cost: 13000, autoClick: 50),
        ListOfButtons(title: "Buy a Mouse Factory!", subtitle: "Buy a factory that produces mouses to distribute to your workers!", amountOfClickIncrease: 1000, cost: 20000, autoClick: 70),
        ListOfButtons(title: "Clicker Island!", subtitle: "You buy an entire island for your workers to stay and work! Talk about generosity!", cost: 50000, autoClick: 100),
        ListOfButtons(title: "Intelligent Animals!", subtitle: "Investing in genetic modifications to enhance animals intelligence! Simply brilliant!", amountOfClickIncrease: 500, cost: 100000, autoClick: 500),
        ListOfButtons(title: "Plants?", subtitle: "You grow plants with a special fertiliser to give them the ability to click!", amountOfClickIncrease: 1000, cost: 170000, autoClick: 1500),
        ListOfButtons(title: "Clicker Town!", subtitle: "Your workers that stayed in your island populated and you have an entire clicking island with you as its leader!", amountOfClickIncrease: 5000, cost: 300000, autoClick: 3000),
        ListOfButtons(title: "Clicker Nation!", subtitle: "You were forced to get even more land for your workers to stay because of the sheer amount!", amountOfClickIncrease: 12000, cost: 600000, autoClick: 700),
        ListOfButtons(title: "Clicker Continent!", subtitle: "Your have enough workers to fill a whole continent!", amountOfClickIncrease: 20000, cost: 1000000, autoClick: 1600),
        ListOfButtons(title: "Clicker Planet!", subtitle: "Your workers overtook the whole of Earth! You are now the ruler of the entire planet?!", amountOfClickIncrease: 45000, cost: 1500000, autoClick: 3700),
        ListOfButtons(title: "Mars!", subtitle: "Earth became more advanced with you in charge and you finally developed the technology to travel to Mars! You meet Martians who accept you as their new leader!", amountOfClickIncrease: 95000, cost: 2500000, autoClick: 7300),
        ListOfButtons(title: "The Clicking Solar System!", subtitle: "You finally did it. You took over the *entire* Solar System!", amountOfClickIncrease: 200000, cost: 7000000, autoClick: 15000),
        ListOfButtons(title: "The Milky Way!", subtitle: "Ambitious are we? You took over the whole Milky Way!", amountOfClickIncrease: 420000, cost: 15000000, autoClick: 32000),
        ListOfButtons(title: "The Galaxy!", subtitle: "You took tryharding to a whole new level! Who would have thought this possible!", amountOfClickIncrease: 850000, cost: 45000000, autoClick: 70000),
        ListOfButtons(title: "The..Final..Purchase..", subtitle: "There no way you can get past this one...it was made to be impossible...", amountOfClickIncrease: 42000000, cost: 150000000000, autoClick: 32000000),
    ]
    
    @State private var autoClickTimer: Timer? = nil
    @State private var isAutoClicking = false // Track whether auto-clicking is active or not
    @State private var totalAutoClick = 0 // Track the total auto-click value from all purchased items
    
    var body: some View {
        ZStack {
            Color(.white)
                .ignoresSafeArea(.all)
            VStack {
                Text("you have \(clicks) clicks")
                    .padding()
                    .bold()
                    .underline()
                    .font(.title)
                    .foregroundColor(.black)
                    .background(.black.opacity(0.2))
                    .cornerRadius(20)
                    .padding(10)
                Text("Click multiplier: \(clicksPerClick)x")
                    .padding()
                    .foregroundColor(.white)
                    .background(.gray)
                    .font(.title2)
                    .cornerRadius(10)
                Button {
                    clicks += clicksPerClick
                } label: {
                    Text("Click here to gain clicks")
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                Spacer()
                Spacer()
                NavigationView {
                    ScrollView {
                        Spacer()
                        VStack(spacing: 20) {
                            Text("Purchase to increase your clicks")
                                .bold()
                                .font(.title2)
                                .multilineTextAlignment(.center)
                                .padding()
                            
                            ForEach(buttons) { button in
                                Button {
                                    if clicks < button.cost {
                                        showAlert = true
                                    } else {
                                        clicks -= button.cost
                                        if button.autoClick > 0 {
                                            totalAutoClick += button.autoClick // Add auto-click value from the purchased item
                                            if !isAutoClicking {
                                                startAutoClickTimer()
                                                isAutoClicking = true
                                            }
                                        }
                                        clicksPerClick += button.amountOfClickIncrease
                                    }
                                } label: {
                                    VStack {
                                        Text(button.title)
                                            .foregroundColor(.white)
                                            .font(.title2)
                                            .bold()
                                        Text(button.subtitle)
                                            .foregroundColor(.white)
                                            .font(.subheadline)
                                        Text("Improve your click multiplier by \(button.amountOfClickIncrease)x" + (button.autoClick > 0 ? ", and get \(button.autoClick) auto-clicks per second!" : ""))
                                            .foregroundColor(.white)
                                            .font(.subheadline)
                                            .bold()
                                            .underline()
                                            .padding()
                                        Text("cost: \(button.cost) clicks")
                                            .foregroundColor(.white)
                                            .font(.subheadline)
                                            .bold()
                                            .multilineTextAlignment(.leading)
                                    }
                                    .frame(width: 325, height: 230)
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .onDisappear {
            stopAutoClickTimer()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Don't try to cheat the system bozo!"), message: Text("I know you don't have enough clicks or you wouldn't be seeing this! 😡"), dismissButton: .default(Text("I'm sorry!")))
        }
    }
    
    private func startAutoClickTimer() {
        autoClickTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            clicks += totalAutoClick
        }
    }
    
    private func stopAutoClickTimer() {
        autoClickTimer?.invalidate()
        autoClickTimer = nil
        isAutoClicking = false
        totalAutoClick = 0 // Reset total auto-click when the timer is stopped
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
