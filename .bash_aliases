# https://github.com/wtfix/wtbash

# TODO to make working with zsh
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'


alias ll='ls -lha'
alias la='ls -lha'
alias l='ls -CF'
alias llast="ll -ltr"


alias rehash="source ~/.bashrc"


# Monitor mode on/off
# TODO unify interface name !wlp2s0mon
alias monoff="sudo airmon-ng stop wlp2s0mon"
alias monon="sudo airmon-ng start wlp2s0"
alias ad="sudo airodump-ng --manufacturer --uptime --wps  --band abg wlp2s0mon"
# TODO $WP
alias ag="airgraph-ng -g CAPR -i surround.csv -o $WP.png"


# Wifite shortcuts
alias wf="sudo wifite -mac --showb --showm -ab -wpat 2000 --num-deauths 4"
alias wfi="sudo wifite -mac -inf --showb --showm -ab -wpat 1000 --nodeauths --skip-crack -p 60 -E PASS_THIS_WIFI"


alias hc="hashcat -m 2500 "


# Bash aliases handling
alias aliases="cat ~/.bash_aliases && echo \"\n\""
alias aliases_edit="mcedit ~/.bash_aliases"
alias add_alias="echo $1 >> ~/.bash_aliases"


alias pp="ping -c 5 1.1.1.1"
alias nn="netstat -anputW"

# alias note="echo \"\n`date --rfc-3339=seconds` $1\n\" >> ~/notes.txt"
# alias notes="cat ~/notes.txt && echo \"\n\""

# Motion shortcuts
alias motoff="service motion stop && killall -9 motion"
alias motionoff="motoff"
alias motionon="service motion start"
alias moton="motionon"
alias motionwtf="service motion status"
# TODO unify motion dir: set, create, get
alias gotomotion="cd /motion"


# OS:PARROT fix
alias dnss="service dnsmasq start && service NetworkManager restart"

# OS:ARCH OS:MANJARO shortcuts
alias pacman-repair-sig="sudo rm /var/lib/pacman/sync/*db.sig*"
alias pacman-reinit="sudo pacman-key --init && sudo pacman-key --populate archlinux && sudo pacman -Syy"
alias pacman-update="sudo pacman-mirrors -f && yes | sudo pacman -Syyu"

alias klkm="killall lximage-qt & killall mpv & killall parole & killall celluloid & killall mplayer & killall nomacs"

# OS:DEBIAN shortcuts
apt-updater()
{
    apt-get update && apt-get dist-upgrade -Vy && apt-get autoremove -y && apt-get autoclean && apt-get clean
}

apt-cleaner()
{
    apt-get autoremove -y && apt-get autoclean && apt-get clean
}


# Shortcuts
dush()
{
    du -sh $1 | sort -h
}

mkdircd()
{
    mkdir -p $1 && cd $1
}

youtube-to-mp3()
{
    youtube-dl  -x --audio-format mp3 --audio-quality 0 "$1"
}



#### FFMPEG shortcuts
rand=$$;

#  ffconvert flac mp3
ffconvert () {
    find -type f -name "*.$1" -print0 | while read -d $'\0' a
    do
        ffmpeg -i "$a" -qscale:a 0 "${a[@]/%$1/$2}" < /dev/null
    done
    rm -I "*.$1"
}

video-rotate-right()
{
    ffmpeg -i $1 -vf "transpose=1" c90_$RANDOM_$1
}
alias vidrr=video-rotate-right

video-rotate-right-flip()
{
    ffmpeg -i $1 -vf "transpose=3" c90flr_$RANDOM_$1
}
alias vidrrf=video-rotate-right-flip

video-rotate-left()
{
    ffmpeg -i $1 -vf "transpose=2" cc90_$RANDOM_$1
}
alias vidrl=video-rotate-left

video-rotate-left-flip()
{
    ffmpeg -i $1 -vf "transpose=0" cc90fll_$RANDOM_$1
}
alias vidrlf=video-rotate-left-flip

video-rotate-down()
{
    ffmpeg -i $1 -vf "transpose=2, transpose=2" c180_$RANDOM_$1
}
alias vidrd=video-rotate-down

video-trim()
{
    ffmpeg -i $1 -ss $2 -t $3 -async 1 cut_$rand_$1
}
alias vidtr=video-trim

video-stabilize()
{
    ffmpeg -i $1 -vf vidstabdetect -f null -
    ffmpeg -i $1 -vf vidstabtransform stab_$RANDOM_$1
}
alias vidstab=video-stabilize

video-back-and-forth()
{
    ffmpeg -i $1 -filter_complex "[0]reverse[r];[0][r]concat" bnf_$rand_$1
}
alias vidbnf=video-back-and-forth

video-trim-and-back-and-forth()
{
    video-trim()
    video-back-and-forth(cut_$rand_$1)
}
alias vidtrbf=video-trim-and-back-and-forth

video-flip-horizontally()
{
    ffmpeg -i $1 -vf hflip fliph_$RANDOM_$1
}
alias vidfh=video-flip-horizontally

video-flip-vertically()
{
    ffmpeg -i $1 -vf vflip flipv_$RANDOM_$1
}
alias vidfv=video-flip-vertically

lst()
{
    echo "$1" >> ./lst
}

video-create-list()
{
    echo "">mylist.txt
    for f in $1; do echo "file '$f'" >> mylist.txt; done
}

video-join()
{
    ffmpeg -f concat -safe 0 -i mylist.txt -c copy $1
}

video-create-from-image-and-audio()
{
    ffmpeg -loop 1 -i $1 -i $2 -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -c:v libx264 -tune stillimage -c:a aac -b:a 192k -pix_fmt yuv420p -shortest $3

}

